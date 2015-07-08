Qt.include("three/build/three.js")

var camera, scene, renderer
var objects, lights
var background, backScene, backCamera

function initializeGL(canvas) {
    camera = new THREE.PerspectiveCamera(30, canvas.width / canvas.height, 1, 10000)
    camera.rotation.x = (1 / 4) * Math.PI
    camera.position.y = -1900
    camera.position.z = 1750

    scene = new THREE.Scene()

    var ambientLight = new THREE.AmbientLight(0x606060)
    scene.add(ambientLight)

    var pointLight = new THREE.PointLight(0xffffff, 1.0, 15000)
    pointLight.position.y = 250
    pointLight.position.z = 500
    scene.add(pointLight)

    lights = [ambientLight, pointLight]

    objects = []
    var startAngle = Math.PI / 2
    for (var i in canvas.items) {
        var item = canvas.items[i]
        console.log(item.percentage)
        var angle = item.percentage * 2 * Math.PI
        var geometry = drawPie(angle)

        var material = new THREE.MeshPhongMaterial({ color: String(item.color), shading: THREE.SmoothShading })
        var mesh = new THREE.Mesh(geometry, material)
        mesh.rotation.z = startAngle
        startAngle += angle

        scene.add(mesh)
        objects.push({
            item: item,
            mesh: mesh,
            percentage: item.percentage,
        })
    }

    // Background rendering
    backScene = new THREE.Scene()

    var texture = THREE.ImageUtils.loadTexture("qrc:/assets/background.jpg")
    background = new THREE.Mesh(new THREE.PlaneBufferGeometry(2, 2, 0), new THREE.MeshBasicMaterial({ map: texture }))
    background.material.depthTest = false
    background.material.depthWrite = false
    backScene.add(background)

    backCamera = new THREE.Camera()
    backScene.add(backCamera)

    renderer = new THREE.Canvas3DRenderer({ canvas: canvas, devicePixelRatio: canvas.devicePixelRatio })
    renderer.setSize(canvas.width, canvas.height)
    renderer.autoClear = false
}

function paintGL(canvas) {
    for (var i in objects) {
        var object = objects[i]
        if (object.item.percentage !== object.percentage) {
            updatePie()
            break
        }
    }
    renderer.clear()
    renderer.render(backScene, backCamera)
    renderer.render(scene, camera)
}

function resizeGL(canvas) {
    if (!camera)
        return
    camera.aspect = canvas.width / canvas.height
    camera.updateProjectionMatrix()
    renderer.setSize(canvas.width, canvas.height)
}

function drawPie(angle) {
    if (angle <= 0)
        angle = 0.001
    var shape = new THREE.Shape()
    shape.moveTo(0, 0)
    shape.ellipse(0, 0, 800, 800, 0, angle, true)
    return new THREE.ExtrudeGeometry(shape, { amount: 100, curveSegments: 36 })
}

function updatePie() {
    var startAngle = Math.PI / 2
    for (var i in objects) {
        var object = objects[i]
        var percentage = object.item.percentage
        var angle = percentage * 2 * Math.PI
        if (percentage !== object.percentage) {
            var pie = drawPie(angle)
            object.mesh.geometry.vertices = pie.vertices
            object.mesh.geometry.faces = pie.faces
            object.mesh.geometry.verticesNeedUpdate = true
            object.mesh.geometry.elementsNeedUpdate = true
            object.percentage = percentage
        }
        object.mesh.rotation.z = startAngle
        startAngle += angle
    }
}

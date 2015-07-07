Qt.include("three/build/three.js")

var camera, scene, light, renderer
var objects

function initializeGL(canvas) {
    camera = new THREE.PerspectiveCamera(30, canvas.width / canvas.height, 1, 10000)
    camera.rotation.x = (1 / 4) * Math.PI
    camera.position.y = -1900
    camera.position.z = 1750

    scene = new THREE.Scene()

    light = new THREE.HemisphereLight(0xffffff, 0x555555)
    scene.add(light)

    objects = []
    var startAngle = 0
    for (var i in canvas.items) {
        var item = canvas.items[i]

        var shape = new THREE.Shape()
        shape.moveTo(0, 0)
        shape.ellipse(0, 0, 800, 800, startAngle, startAngle + 0.5 * Math.PI, true)
        startAngle += 0.5 * Math.PI

        var geometry = new THREE.ExtrudeGeometry(shape, { amount: 100, curveSegments: 64 })
        var material = new THREE.MeshLambertMaterial({ color: String(item.color) })
        var mesh = new THREE.Mesh(geometry, material)

        scene.add(mesh)
        objects.push({
            shape: shape,
            geometry: geometry,
            material: material,
            mesh: mesh
        })
    }

    renderer = new THREE.Canvas3DRenderer({ canvas: canvas, devicePixelRatio: canvas.devicePixelRatio })
    renderer.setSize(canvas.width, canvas.height)
}

function paintGL(canvas) {
    renderer.render(scene, camera)
}

function resizeGL(canvas) {
    if (!camera)
        return
    camera.aspect = canvas.width / canvas.height
    camera.updateProjectionMatrix()
    renderer.setSize(canvas.width, canvas.height)
}

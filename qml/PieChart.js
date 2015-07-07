Qt.include("three/build/three.js")

var camera, scene, light, renderer
var geometry, material, mesh

function initializeGL(canvas) {
    camera = new THREE.PerspectiveCamera(30, canvas.width / canvas.height, 1, 10000)
    camera.rotation.x = (1 / 4) * Math.PI
    camera.position.y = -1900
    camera.position.z = 1750

    scene = new THREE.Scene()

    light = new THREE.HemisphereLight(0xffffff, 0x555555)
    scene.add(light)

    var shape = new THREE.Shape()
    shape.moveTo(0, 0)
    shape.ellipse(0, 0, 800, 800, 0, 2 * Math.PI, true)
    geometry = new THREE.ExtrudeGeometry(shape, { amount: 100, curveSegments: 64 })
    material = new THREE.MeshLambertMaterial({ color: 0x009688 })

    mesh = new THREE.Mesh(geometry, material)
    scene.add(mesh)

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

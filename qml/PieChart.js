Qt.include("three/build/three.js")

var camera, scene, renderer
var geometry, material, mesh

function initializeGL(canvas) {
    camera = new THREE.PerspectiveCamera(75, canvas.width / canvas.height, 1, 10000)
    camera.position.z = 1000

    scene = new THREE.Scene()

    geometry = new THREE.BoxGeometry(200, 200, 200)
    material = new THREE.MeshBasicMaterial({ color: 0x00ff00, wireframe: true })

    mesh = new THREE.Mesh(geometry, material)
    scene.add(mesh)

    renderer = new THREE.Canvas3DRenderer({ canvas: canvas, devicePixelRatio: canvas.devicePixelRatio })
    renderer.setSize(canvas.width, canvas.height)
}

function paintGL(canvas) {
    mesh.rotation.x += 0.01
    mesh.rotation.y += 0.02
    renderer.render(scene, camera)
}

function resizeGL(canvas) {
    if (!camera)
        return
    camera.aspect = canvas.width / canvas.height
    camera.updateProjectionMatrix()
    renderer.setSize(canvas.width, canvas.height)
}

///@package io.alkapivo.visu.service.bullet

///@enum
function _BulletFeatureType(): _GridItemFeatureType() constructor {
    FOLLOW_PLAYER = "followPlayer"
}
global.__BulletFeatureType = new _BulletFeatureType()
#macro BulletFeatureType global.__BulletFeatureType



function _BULLET_FEATURES(): _GRID_ITEM_FEATURES() constructor {
    followPlayer = method(this, function(json) {
        return new BulletFeatureFollowPlayer(json)
    })
}
global.__BULLET_FEATURES = new _BULLET_FEATURES()
#macro BULLET_FEATURES global.__BULLET_FEATURES


///@param {Struct} json
function BulletFeatureFollowPlayer(json): GridItemFeature() constructor {

    ///@override
    ///@param {Bullet} bullet
    ///@param {VisuController} controller
    static update = function(bullet, controller) {
        var player = controller.playerService.player
        if (Core.isType(player, Player)) {
            bullet.angle = Math.fetchAngle(bullet.x, bullet.y, player.x, player.y)      
        }
    }
}

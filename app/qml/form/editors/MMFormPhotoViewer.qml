/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

import QtQuick
import QtQuick.Controls
import "../../components"
import "../../inputs"

/*
 * Photo viewer for feature form.
 * Its purpose is to show image based on the provided URL.
 * It is not combined with MMPhotoFormEditor as it would be not possible to use it in the gallery then.
 *
 * Serves as a base class for MMPhotoFormEditor.
 */

MMBaseInput {
  id: root

  // TODO:
  // - add photo preview panel (zoom),
  // - handle "photo notAvailable" state
  // - handle empty state - add "capture photo" and "choose from gallery" signals
  // - scale images well - based on the root.size

  property url photoUrl: ""
  property bool hasCameraCapability: true

  property alias photoComponent: photo

  signal trashClicked()
  signal capturePhotoClicked()
  signal chooseFromGalleryClicked()

  contentItemHeight: 160 * __dp
  spacing: 0
  radius: 20 * __dp

  states: [
    State {
      name: "valid"
    },
    State {
      name: "notSet"
    },
    State {
      name: "notAvailable"
    }
  ]

  state: "notSet"

  onContentClicked: {
    // TODO: open preview
  }

  content: MMPhoto {
    id: photo

    width: root.width
    height: root.contentItemHeight
    photoUrl: root.photoUrl

    fillMode: Image.PreserveAspectCrop

    MouseArea {
      anchors.fill: parent
      onClicked: root.contentClicked()
    }

    MMRoundButton {
      anchors {
        right: parent.right
        bottom: parent.bottom
        rightMargin: 10 * __dp
        bottomMargin: 10 * __dp
      }

      bgndColor: __style.negativeColor
      iconSource: __style.deleteIcon
      iconColor: __style.grapeColor
      visible: true//enabled && ( photo.status === Image.Ready || photo.status === Image.Error )
      onClicked: root.trashClicked()
    }
  }
}
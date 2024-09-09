import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/shower_session.dart';
import '../../../../ui/theme/theme.dart';

const _strokeWidth = 4.0;
const _valveColor = Color(0xFFD9D9D9);

const _centerRadius = 10.0;
const _centerMarkerRadius = 6.0;
const _connectorWidth = 4.0;
const _connectorHeight = 20.0;
const _connectorEdgeRadius = 6.0;

Rect _centerBorders(double top, double left) =>
    Rect.fromLTRB(
      -_centerRadius + left,
      -_centerRadius + top,
      _centerRadius + left,
      _centerRadius + top,
    );

Rect _centerMarkerBorders(double top, double left) =>
    Rect.fromLTRB(
      -_centerMarkerRadius + left,
      -_centerMarkerRadius + top,
      _centerMarkerRadius + left,
      _centerMarkerRadius + top,
    );

Rect _topConnectorBorders(double top, double left) =>
    Rect.fromLTRB(
      -_connectorWidth / 2 + left,
      -_centerMarkerRadius - _connectorHeight + top,
      _connectorWidth / 2 + left,
      -_centerMarkerRadius + top,
    );

Rect _topConnectorEdgeBorders(double top, double left) =>
    Rect.fromLTRB(
      -_connectorEdgeRadius + left,
      -_centerMarkerRadius - _connectorHeight - _connectorEdgeRadius + top,
      _connectorEdgeRadius + left,
      -_centerMarkerRadius - _connectorHeight + _connectorEdgeRadius + top,
    );

Rect _bottomConnectorBorders(double top, double left) =>
    Rect.fromLTRB(
      -_connectorWidth / 2 + left,
      _centerMarkerRadius + top,
      _connectorWidth / 2 + left,
      _centerMarkerRadius + _connectorHeight + top,
    );

Rect _bottomConnectorEdgeBorders(double top, double left) =>
    Rect.fromLTRB(
      -_connectorEdgeRadius + left,
      _centerMarkerRadius + _connectorHeight - _connectorEdgeRadius + top,
      _connectorEdgeRadius + left,
      _centerMarkerRadius + _connectorHeight + _connectorEdgeRadius + top,
    );

Rect _leftConnectorBorders(double top, double left) =>
    Rect.fromLTRB(
      -_centerMarkerRadius - _connectorHeight + left,
      -_connectorWidth / 2 + top,
      -_centerMarkerRadius + left,
      _connectorWidth / 2 + top,
    );

Rect _leftConnectorEdgeBorders(double top, double left) =>
    Rect.fromLTRB(
      -_centerMarkerRadius - _connectorHeight - _connectorEdgeRadius + left,
      -_connectorEdgeRadius + top,
      -_centerMarkerRadius - _connectorHeight + _connectorEdgeRadius + left,
      _connectorEdgeRadius + top,
    );

Rect _rightConnectorBorders(double top, double left) =>
    Rect.fromLTRB(
      _centerMarkerRadius + left,
      -_connectorWidth / 2 + top,
      _centerMarkerRadius + _connectorHeight + left,
      _connectorWidth / 2 + top,
    );

Rect _rightConnectorEdgeBorders(double top, double left) =>
    Rect.fromLTRB(
      _centerMarkerRadius + _connectorHeight - _connectorEdgeRadius + left,
      -_connectorEdgeRadius + top,
      _centerMarkerRadius + _connectorHeight + _connectorEdgeRadius + left,
      _connectorEdgeRadius + top,
    );

class ValvePainter extends CustomPainter {
  final ShowerPhase phase;
  final double top;
  final double left;

  final _theme = GetIt.instance<AppTheme>();

  ValvePainter({required this.phase, this.top = 0, this.left = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final valvePaint = Paint()
      ..strokeWidth = _strokeWidth
      ..color = _valveColor
      ..style = PaintingStyle.fill;

    final valveMarkerPaint = Paint()
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.fill
      ..color = switch (phase) {
        ShowerPhase.hot => _theme.colors.background.hot,
        ShowerPhase.cold => _theme.colors.background.cold,
      };

    canvas.drawOval(_centerBorders(top, left), valvePaint);
    canvas.drawOval(_centerMarkerBorders(top, left), valveMarkerPaint);
    canvas.drawRect(_topConnectorBorders(top, left), valvePaint);
    canvas.drawOval(_topConnectorEdgeBorders(top, left), valvePaint);
    canvas.drawRect(_bottomConnectorBorders(top, left), valvePaint);
    canvas.drawOval(_bottomConnectorEdgeBorders(top, left), valvePaint);
    canvas.drawRect(_leftConnectorBorders(top, left), valvePaint);
    canvas.drawOval(_leftConnectorEdgeBorders(top, left), valvePaint);
    canvas.drawRect(_rightConnectorBorders(top, left), valvePaint);
    canvas.drawOval(_rightConnectorEdgeBorders(top, left), valvePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import '../../../../../../core/core.dart';

abstract class SpecialtyQueueEntity implements SpecialtyEntity{
  late final String time;
  late final int patients;
  late final int medics;
  bool get showTime;
}
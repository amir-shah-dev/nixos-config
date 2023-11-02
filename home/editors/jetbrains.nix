{ programs }:
  let ides = with programs.jetbrains; [
	pycharm
	webstom
  ];
  in ides



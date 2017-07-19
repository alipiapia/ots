function imgSlideShow(_obj){
	var _box = $(_obj.showbox);
	var _sum = $(_obj.showsum);
	var _arr = _sum.find(_obj.showpart);
	var _length = _arr.length;
	var _menu = $(_obj.menuid);
	var _index = 0;
	var _mindex = 0;
	
	_box.css({"overflow":"hidden","width":_obj.showw+"px","height":_obj.showh+"px","position":"relative"});
	_arr.css({"width":_obj.showw+"px","height":_obj.showh+"px","float":"left"});
	var _sumwidth = _length * _obj.showw;
	_sum.css({"width":_sumwidth+"px","position":"relative","left":"0px"});
	
	_menu.append("<ul></ul>");
	var _menusum = _menu.find("ul");
	for(var i=0;i<_length;i++){
		var _mstr = "<li></li>";
		_menusum.append(_mstr);
		_menu.find("li").eq(i).append(_arr.eq(i).find(_obj.showimg).clone());
		}
	var _marr = _menusum.find("li");
	_marr.eq(_index).addClass(_obj.menusel);
	_menusum.css({"position":"relative","left":"0px","width":_sumwidth+"px"});
	var _menuwidth = _obj.menumove * _obj.menunum;
	_menu.css({"overflow":"hidden","width":_menuwidth+"px"});
	_marr.css({"float":"left","position":"relative"});
	
	
	//下一页
	var _nextpage = function(){
		_index++;
		if(_index >= _length){_index = _length-1;}
		var _imgmove = -_index * _obj.showw;
		if(_sum.is(":animated")){_sum.stop(true,true);}
		_sum.animate({left:_imgmove+"px"},300);
		_marr.eq(_index).addClass(_obj.menusel).siblings().removeClass(_obj.menusel);
		
		var _jx = _mindex + _obj.menunum;
		if(_index == _jx){
			_mindex++;
			var _menumove = -_mindex * _obj.menumove;
			if(_menusum.is(":animated")){_menusum.stop(true,true);}
			_menusum.animate({left:_menumove+"px"},300);
		}
		
	};//fun END
	
	//上一页
	var _lastpage = function(){
		_index--;
		if(_index < 0){_index = 0;}
		var _imgmove = -_index * _obj.showw;
		if(_sum.is(":animated")){_sum.stop(true,true);}
		_sum.animate({left:_imgmove+"px"},300);
		_marr.eq(_index).addClass(_obj.menusel).siblings().removeClass(_obj.menusel);
		
		var _jx = _mindex;
		if(_index+1 == _jx && _jx > 0){
			_mindex--;
			var _menumove = -_mindex * _obj.menumove;
			if(_menusum.is(":animated")){_menusum.stop(true,true);}
			_menusum.animate({left:_menumove+"px"},300);
		}
		
	};//fun END
	
	$(_obj.nextid).click(function(){ _nextpage(); });
	$(_obj.lastid).click(function(){ _lastpage(); });
	$(_obj.menunext).click(function(){ _nextpage(); });
	$(_obj.menulast).click(function(){ _lastpage(); });
	
	_marr.hover(function(){
		_index = $(this).index();
		var _imgmove = -_index * _obj.showw;
		if(_sum.is(":animated")){_sum.stop(true,true);}
		_sum.animate({left:_imgmove+"px"},300);
		_marr.eq(_index).addClass(_obj.menusel).siblings().removeClass(_obj.menusel);
	});
	
}




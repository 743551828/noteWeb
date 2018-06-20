<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>基于Bootstrap3的带记事功能的全年日历插件</title>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.5/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/default.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-year-calendar.min.css">
    <style type="text/css">
        #calendar {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>
    <!--[if IE]>
    <script src="http://libs.baidu.com/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
</head>
<body>
<article class="jq22-container">
    <header class="jq22-header">
        <h1>带记事功能的全年日历 <span>A fully customizable year calendar</span></h1>
    </header>
    <div id="calendar"></div>
</article>

<div class="modal modal-fade" id="event-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">
                    Event
                </h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="event-index" value="">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="min-date" class="col-sm-4 control-label">Name</label>
                        <div class="col-sm-7">
                            <input name="event-name" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="min-date" class="col-sm-4 control-label">Location</label>
                        <div class="col-sm-7">
                            <input name="event-location" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="min-date" class="col-sm-4 control-label">Dates</label>
                        <div class="col-sm-7">
                            <div class="input-group input-daterange" data-provide="datepicker">
                                <input name="event-start-date" type="text" class="form-control" value="2012-04-05">
                                <span class="input-group-addon">to</span>
                                <input name="event-end-date" type="text" class="form-control" value="2012-04-19">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="save-event">
                    Save
                </button>
            </div>
        </div>
    </div>
</div>

<script src="http://www.jq22.com/jquery/2.1.1/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="js/jquery-2.1.1.min.js"><\/script>')</script>
<script type="text/javascript" src="bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="js/bootstrap-year-calendar.min.js"></script>
<script type="text/javascript" src="js/bootstrap-popover.js"></script>
<script type="text/javascript">
    function editEvent(event) {
        $('#event-modal input[name="event-index"]').val(event ? event.id : '');
        $('#event-modal input[name="event-name"]').val(event ? event.name : '');
        $('#event-modal input[name="event-location"]').val(event ? event.location : '');
        $('#event-modal input[name="event-start-date"]').datepicker('update', event ? new Date(event.startDate) : '');
        $('#event-modal input[name="event-end-date"]').datepicker('update', event ? new Date(event.endDate) : '');
        $('#event-modal').modal();
    }

    //删除方法
    function deleteEvent(event) {
        // event.startDate=new Date(event.startDate);
        // event.endDate=new Date(event.endDate)
        $.ajax({
            url: 'delete',
            type: 'post',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: JSON.stringify(event),
            success: function (result) {
                $('#calendar').data('calendar').setDataSource(result);
                $('#event-modal').modal('hide');
            }
        })
    }

    function saveEvent() {
        //event为一个事件
        var event = {
            id: $('#event-modal input[name="event-index"]').val(),
            name: $('#event-modal input[name="event-name"]').val(),
            location: $('#event-modal input[name="event-location"]').val(),
            startDate: $('#event-modal input[name="event-start-date"]').datepicker('getDate'),
            endDate: $('#event-modal input[name="event-end-date"]').datepicker('getDate')
        }

        var dataSource = $('#calendar').data('calendar').getDataSource();
        //id存在，则表示更新
        if (event.id) {
            $.ajax({
                url: 'update',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(event),
                success: function (result) {
                    $('#calendar').data('calendar').setDataSource(result);
                    $('#event-modal').modal('hide');
                }
            })
        }
        //不存在，则表示添加
        else {
            $.ajax({
                url: 'save',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: JSON.stringify(event),
                success: function (result) {
                    $('#calendar').data('calendar').setDataSource(result);
                    $('#event-modal').modal('hide');
                }
            })
        }


    }

    $(function () {
        $.ajax({
            url: 'findAll',
            type: 'get',
            contentType: false,
            processData: false,
            dataType: 'json',
            success: function (result) {
                $('#calendar').calendar({
                    enableContextMenu: true,
                    enableRangeSelection: true,
                    contextMenuItems: [
                        {
                            text: 'Update',
                            click: editEvent
                        },
                        {
                            text: 'Delete',
                            click: deleteEvent
                        }
                    ],
                    selectRange: function (e) {
                        editEvent({startDate: e.startDate, endDate: e.endDate});
                    },
                    mouseOnDay: function (e) {
                        if (e.events.length > 0) {
                            var content = '';

                            for (var i in e.events) {
                                content += '<div class="event-tooltip-content">'
                                    + '<div class="event-name" style="color:' + e.events[i].color + '">' + e.events[i].name + '</div>'
                                    + '<div class="event-location">' + e.events[i].location + '</div>'
                                    + '</div>';
                            }

                            $(e.element).popover({
                                trigger: 'manual',
                                container: 'body',
                                html: true,
                                content: content
                            });

                            $(e.element).popover('show');
                        }
                    },
                    mouseOutDay: function (e) {
                        if (e.events.length > 0) {
                            $(e.element).popover('hide');
                        }
                    },
                    dayContextMenu: function (e) {
                        $(e.element).popover('hide');
                    },
                    dataSource: result
                });

                $('#save-event').click(function () {
                    saveEvent();
                });
            }
        })

    });
</script>
</body>
</html>
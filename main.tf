resource "datadog_timeboard" "lambda" {
  title       = "${var.product_domain} - ${var.function_name} - Lambda"
  description = "A generated timeboard for Lambda"

  template_variable {
    default = "${var.function_name}"
    name    = "function_name"
    prefix  = "functionname"
  }

  graph {
    title     = "Duration"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.lambda.duration{$function-name} by {functionname}"
      type = "line"
    }

    request {
      q    = "avg:aws.lambda.duration.sum{$function-name} by {functionname}"
      type = "line"
    }

    request {
      q    = "avg:aws.lambda.duration.maximum{$function-name} by {functionname}"
      type = "line"
    }

    request {
      q    = "avg:aws.lambda.duration.minimum{$function-name} by {functionname}"
      type = "line"
    }
  }

  graph {
    title     = "Errors"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.lambda.errors{$function-name} by {functionname}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Invocations"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.lambda.invocations{$function-name} by {functionname}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Throttles"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.lambda.throttles{$function-name} by {functionname}.as_count()"
      type = "area"
    }
  }
}

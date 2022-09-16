{% macro get_develop_metrics_dictionary(metric_tree, develop_yml) %}

{% set metrics_dictionary = {} %}

{% for metric_name in metric_tree.full_set %}
    {% set metric_definition = develop_yml[metric_name]%}
    
    {% do metrics_dictionary.update({metric_definition.name:{}})%}
    {% do metrics_dictionary[metric_name].update({'name': metric_definition.name})%}
    {% do metrics_dictionary[metric_name].update({'calculation_method': metric_definition.calculation_method})%}
    {% do metrics_dictionary[metric_name].update({'expression': metric_definition.expression})%}
    {% do metrics_dictionary[metric_name].update({'timestamp': metric_definition.timestamp})%}
    {% do metrics_dictionary[metric_name].update({'time_grains': metric_definition.time_grains})%}
    {% do metrics_dictionary[metric_name].update({'dimensions': metric_definition.dimensions})%}
    {% do metrics_dictionary[metric_name].update({'filters': metric_definition.filters})%}

    {% set metric_model_name = metrics.get_metric_model_name(metric_model=metric_definition.model) %}
    {% do metrics_dictionary[metric_name].update({'metric_model': metrics.get_model_relation(metric_model_name, metric_name)}) %}

    {% if metric_definition.window %}
        {% do metrics_dictionary[metric_name].update({'window': metric_definition.window}) %}
    {% else %}
        {% do metrics_dictionary[metric_name].update({'window': None}) %}
    {% endif %}

{% endfor %}

{% do return(metrics_dictionary) %}

{% endmacro %}
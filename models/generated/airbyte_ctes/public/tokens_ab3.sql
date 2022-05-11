{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tokens_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'address',
        'ticker_symbol',
    ]) }} as _airbyte_tokens_hashid,
    tmp.*
from {{ ref('tokens_ab2') }} tmp
-- tokens
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


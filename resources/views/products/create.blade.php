@extends('layouts.app')

@section('content')
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Create Product</h1>
    </div>
    <div id="app">
        <template>
            <section>
                <form action="{{ route('product.store') }}" method="post">
                    @csrf
                    @method('post')
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="">Product Name</label>
                                        <input type="text" name="title" placeholder="Product Name" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="">Product SKU</label>
                                        <input type="text" name="sku" placeholder="Product SKU" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="">Description</label>
                                        <textarea id="" name="description" cols="30" rows="4" class="form-control"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Media</h6>
                                </div>
                                <div class="card-body border">
                                    {{-- <vue-dropzone ref="myVueDropzone" id="dropzone" :options="dropzoneOptions"></vue-dropzone> --}}
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Variants</h6>
                                </div>
                                <div class="card-body" id="pVerientPart">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="">Option</label>
                                                <select class="form-control" name="vri[]">
                                                    @foreach($variants as $item)
                                                        <option value="{{ $item->id}}">{{ $item->title }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label class="float-right text-primary remove" style="cursor: pointer;" onclick="if(value > 1){$(this).closest('.row').remove();value = value-1;}">Remove</label>
                                                <input class="form-control" name="vriv[]">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <button type="button" onclick="addMore()" class="btn btn-primary">Add another option</button>
                                    <button type="button" onclick="setData()" class="btn btn-success">Add Variants</button>
                                </div>

                                <div class="card-header text-uppercase">Preview</div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <td>Variant</td>
                                                <td>Price</td>
                                                <td>Stock</td>
                                            </tr>
                                            </thead>
                                            <tbody id="preview">
                                            
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-lg btn-primary">Save</button>
                    <button type="button" class="btn btn-secondary btn-lg">Cancel</button>
                </form>
            </section>
        </template>
    </div>
@endsection


@section('scripts')
    
    <script> 
        var value = 1;
        function addMore(){
            var tr    = $('#pVerientPart .row:first-child').clone();
            if(value < 3){
                $('#pVerientPart').append(tr);
                value = value+1;
            }
        }

        function setData(){
            var a = $("select[name='vri[]']").map(function(){return $(this).val();}).get();
            var b = $("input[name='vriv[]']").map(function(){return $(this).val();}).get();
            var vdata = '';
            var vpdata = '';

            for(var i = 0; i < a.length; i++){
                
                vdata +=  a[i];
                if(i < 2){
                    vdata += '/'
                }
                vpdata += b[i];
                if(i < 2){
                    vpdata += '/'
                }             
            }

            var row = '<tr>'+
                        '<td>'+
                            '<input type="text" class="form-control" value="'+vpdata+'" name="variant[]" readonly>'+
                            '<input type="hidden" class="form-control" value="'+vdata+'" name="variant_id[]">'+
                        '</td>'+
                        '<td>'+
                            '<input type="text" class="form-control" name="price[]" value="0">'+
                        '</td>'+
                        '<td>'+
                            '<input type="text" class="form-control" name="stock[]" value="0">'+
                        '</td>'+
                    '</tr>';
            $('#preview').append(row);
            $("input[name='vriv[]']").val('');
        }
    </script>
    
@endsection

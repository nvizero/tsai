require 'test_helper'

class IdSeqsControllerTest < ActionController::TestCase
  setup do
    @id_seq = id_seqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:id_seqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create id_seq" do
    assert_difference('IdSeq.count') do
      post :create, id_seq: { pre_id: @id_seq.pre_id, seq: @id_seq.seq }
    end

    assert_redirected_to id_seq_path(assigns(:id_seq))
  end

  test "should show id_seq" do
    get :show, id: @id_seq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @id_seq
    assert_response :success
  end

  test "should update id_seq" do
    patch :update, id: @id_seq, id_seq: { pre_id: @id_seq.pre_id, seq: @id_seq.seq }
    assert_redirected_to id_seq_path(assigns(:id_seq))
  end

  test "should destroy id_seq" do
    assert_difference('IdSeq.count', -1) do
      delete :destroy, id: @id_seq
    end

    assert_redirected_to id_seqs_path
  end
end

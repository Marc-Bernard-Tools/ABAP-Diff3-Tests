**********************************************************************
* Tests for Source Code Diffs
**********************************************************************
CLASS ltcl_diff_sources DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mt_old TYPE abaptxt255_tab,
      mt_new TYPE abaptxt255_tab.


    METHODS:
      setup,
      test FOR TESTING.

ENDCLASS.

CLASS ltcl_diff_sources IMPLEMENTATION.

  METHOD setup.

    READ REPORT 'Z_DIFFER_TEST_PROG' INTO mt_old.
    cl_abap_unit_assert=>assert_subrc( ).

    READ REPORT 'Z_DIFFER_TEST_PROG_NEW' INTO mt_new.
    cl_abap_unit_assert=>assert_subrc( ).

  ENDMETHOD.

  METHOD test.

    " Compare SAP standard diff with ABAP Differ implementation
    DATA(lt_sap) = zcl_differ_test_sources=>get_delta_sap(
      it_old = mt_old
      it_new = mt_new ).

    DATA(lt_diff) = zcl_differ_test_sources=>get_delta_diff3(
      it_old = mt_old
      it_new = mt_new ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_diff
      exp = lt_sap ).

  ENDMETHOD.

ENDCLASS.
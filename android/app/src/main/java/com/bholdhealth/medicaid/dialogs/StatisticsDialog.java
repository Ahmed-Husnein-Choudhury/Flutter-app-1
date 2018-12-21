package com.bholdhealth.medicaid.dialogs;

import android.app.DialogFragment;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.bholdhealth.medicaid.R;

public class StatisticsDialog extends DialogFragment {

    static LinearLayout load;

    public static StatisticsDialog newInstance(Bundle bundle, LinearLayout loader) {
        StatisticsDialog statisticsDialog = new StatisticsDialog();
        statisticsDialog.setArguments(bundle);
        load=loader;
        return statisticsDialog;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.dialog_statistics, container, false);

        this.setCancelable(false);

        TextView verificationStatistics = rootView.findViewById(R.id.verificationStatistics);
        TextView antispoofingStatistics = rootView.findViewById(R.id.antispoofingStatistics);

        com.bholdhealth.medicaid.Utils.Prefs prefs = com.bholdhealth.medicaid.Utils.Prefs.getInstance();

        int verificationThreshold = prefs.getVerifyThreshold();
        int antispoofingThreshold = prefs.getAntispoofingThreshold();

        float verificationScore = getArguments().getFloat("VERIFICATION_SCORE") * 100;

        verificationStatistics.setText(
                String.format(
                        getString(
                                verificationScore > verificationThreshold ?
                                        R.string.verification_successful :
                                        R.string.verification_failed),
                        verificationScore));

        verificationStatistics.setTextColor(rootView.getContext().getResources().getColor(
                verificationScore > verificationThreshold ? R.color.green : R.color.red));

        if (prefs.getAntispoofingEnabledFlag()) {
            float antispoofingScore = getArguments().getFloat("ANTISPOOFING_SCORE") * 100;

            antispoofingStatistics.setText(
                    String.format(
                            getString(
                                    antispoofingScore > antispoofingThreshold ?
                                            R.string.antispoofing_successful :
                                            R.string.antispoofing_failed),
                            antispoofingScore));


            antispoofingStatistics.setTextColor(rootView.getContext().getResources().getColor(
                    antispoofingScore > antispoofingThreshold ? R.color.green : R.color.red));
        }

        rootView.findViewById(R.id.close_dialog_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                load.setVisibility(View.GONE);
                StatisticsDialog.super.dismiss();
            }
        });

        return rootView;
    }

    @Override
    public void onStart() {
        super.onStart();
        getDialog().getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
    }
}

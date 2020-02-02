package com.example.ratedialog;

import android.content.Context;
import android.os.Handler;
import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;




public class RotationRatingBar extends BaseRatingBar {

    private static Handler sUiHandler = new Handler();

    public RotationRatingBar(Context context) {
        super(context);
    }

    public RotationRatingBar(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    public RotationRatingBar(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    protected void emptyRatingBar() {
        // Need to remove all previous runnable to prevent emptyRatingBar and fillRatingBar out of sync
        sUiHandler.removeCallbacksAndMessages(null);

        int delay = 0;

        for (final PartialView partialView : mPartialViews) {
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    partialView.setEmpty();
                }
            }, delay += 5);
        }
    }

    @Override
    protected void fillRatingBar(final float rating) {
        // Need to remove all previous runnable to prevent emptyRatingBar and fillRatingBar out of sync
        sUiHandler.removeCallbacksAndMessages(null);

        int delay = 0;
        for (final PartialView partialView : mPartialViews) {
            final int ratingViewId = partialView.getId();
            final double maxIntOfRating = Math.ceil(rating);

            if (ratingViewId > maxIntOfRating) {
                partialView.setEmpty();
                continue;
            }

            sUiHandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    if (ratingViewId == maxIntOfRating) {
                        partialView.setPartialFilled(rating);
                    } else {
                        partialView.setFilled();
                    }

                    if (ratingViewId == rating) {
                        Animation rotation = AnimationUtils.loadAnimation(getContext(), R.anim.rotation);
                        partialView.startAnimation(rotation);
                    }

                }
            }, delay += 15);
        }
    }
}

package nakasho.github.io.datepickersample

import android.arch.lifecycle.ViewModel
import android.util.Log
import io.reactivex.disposables.CompositeDisposable
import jp.keita.kagurazaka.rxproperty.RxProperty
import java.util.*

class MainViewModel : ViewModel() {
    private val _disposables = CompositeDisposable();

    val year = RxProperty<Int>()
    val month = RxProperty<Int>()
    val day = RxProperty<Int>()
    val hour = RxProperty<Int>()
    val minute = RxProperty<Int>()
    val buttonText = RxProperty<String>()
    val buttonEnabled = RxProperty<Boolean>()

    init {
        buttonText.set("現在時刻を設定")
        buttonEnabled.set(true)
    }

    fun tapButton() {
        val calendar = Calendar.getInstance()
        year.set(calendar.get(Calendar.YEAR))
        month.set(calendar.get(Calendar.MONTH))
        day.set(calendar.get(Calendar.DAY_OF_MONTH))
        hour.set(calendar.get(Calendar.HOUR))
        minute.set(calendar.get(Calendar.MINUTE))

        buttonText.set("現在時刻設定中")
        buttonEnabled.set(false)
        Log.d("MainViewModel", "tapButton finished")
    }

    fun changeDateTimePicker() {
        buttonText.set("現在時刻を設定")
        buttonEnabled.set(true)
        Log.d("MainViewModel", "changeDateTimePicker finished")
    }

    override fun onCleared() {
        _disposables.clear()
        super.onCleared()
    }
}
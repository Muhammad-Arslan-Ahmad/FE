package com.salesfuse.client.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class Utils {
    
    public static boolean isOk(Integer value) {
        return !(value == null || value.intValue() <= 0);
    }

    public static boolean isOk(Long value) {
        return !(value == null || value.longValue() <= 0);
    }

    public static boolean isOk(String str) {
        return !(str == null || str.trim().isEmpty());
    }

    public static boolean isOk(Enum value) {
        return !(value == null);
    }

    public static String getDateToString(Date date, String dateFormat) {
        if (date == null) {
            return null;
        }

        return (new SimpleDateFormat(dateFormat)).format(date);
    }

    public static Integer getIntegerFromObject(Object object) {
        if (object == null) {
            return null;
        }
        if (object instanceof Integer) {
            return ((Integer) object).intValue();
        } else if (object instanceof Long) {
            return ((Long) object).intValue();
        } else if (object instanceof BigDecimal) {
            return ((BigDecimal) object).intValue();
        } else if (object instanceof BigInteger) {
            return ((BigInteger) object).intValue();
        } else if (object instanceof Short) {
            return ((Short) object).intValue();
        } else if (object instanceof Double) {
            return ((Double) object).intValue();
        } else if(object instanceof Number) {
            return ((Number) object).intValue();
        } else if (object instanceof String) {
            try {
                return Integer.parseInt((String) object);
            } catch (Throwable t) {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public static boolean isOk(Object value) {
        return !(value == null);
    }

    public static Date addDays(Date date, int day) {
        if(date == null) {
            return null;
        }

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, day);
        return cal.getTime();
    }
    public static Date addMonth(Date date, int month) {
        if(date == null) {
            return null;
        }

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, month);
        return cal.getTime();
    }
    public static Date addYear(Date date, int year) {
        if(date == null) {
            return null;
        }

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.YEAR, year);
        return cal.getTime();
    }
    public static Date getCurrentDate(String format) {
        try {
            if(!isOk(format)) {
                format = "dd/MM/yyyy";
            }
            DateFormat df = new SimpleDateFormat(format);
            return df.parse(df.format(new Date()));
        } catch (Throwable t) {
            t.printStackTrace();
        }

        return null;
    }
    

    public static final Date getDate(String date) {
        if(!isOk(date)) {
            return null;
        }

        try {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            return df.parse(date);
        } catch (Throwable t) {
            t.printStackTrace();
            return null;
        }
    }
    
    public static final String getDate(Date date) {
        if(!isOk(date)) {
            return "";
        }

        try {
            DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
            return df.format(date);
        } catch (Throwable t) {
            t.printStackTrace();
            return "";
        }
    }

    public static Date getDate(String date, boolean max) {
        if(!isOk(date)) {
            return null;
        }
        Date convertedDate;
        try {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            convertedDate = df.parse(date);
        } catch (Throwable t) {
            return null;
        }

        if(convertedDate == null) {
            return null;
        }

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(convertedDate);
        if(max) {
            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);
            calendar.set(Calendar.MILLISECOND, 999);
        } else {
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 1);
        }

        return calendar.getTime();
    }
    
    public static Double getDoubleFromStr(String str) {
        try {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < str.length(); i++) {
                if (Character.isDigit(str.charAt(i))) {
                    sb.append(str.charAt(i));
                }
                if (str.charAt(i) == '.') {
                    sb.append(str.charAt(i));
                }
            }

            return Double.parseDouble(sb.toString());
        } catch (Exception ex) {
            return 0.0;
        }
    }

    public static String getCurrencyStr(Double amount) {
        try {
            NumberFormat franceFormat = NumberFormat.getCurrencyInstance(Locale.US);
            String formattedString = franceFormat.format(amount.intValue());
            formattedString = formattedString.split("\\.")[0];
            formattedString = formattedString.replace("$", "") + "$";
            return formattedString;
        } catch (Exception ex) {
            return "0$";
        }
    }
}

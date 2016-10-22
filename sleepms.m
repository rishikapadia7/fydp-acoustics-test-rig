function [ ] = sleepms(duration)
    %sleeps the specified duration + additional margin amount of
    %milliseconds
    java.lang.Thread.sleep(duration + 500);
end
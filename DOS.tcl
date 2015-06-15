# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     19                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      6803                      ;# X dimension of topography
set val(y)      2447                      ;# Y dimension of topography
set val(stop)   15                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 19 nodes
set n0 [$ns node]
$n0 set X_ 2799
$n0 set Y_ 2227
$n0 set Z_ 0.0
$ns initial_node_pos $n0 80
set n1 [$ns node]
$n1 set X_ 2939
$n1 set Y_ 2321
$n1 set Z_ 0.0
$ns initial_node_pos $n1 80
set n2 [$ns node]
$n2 set X_ 3090
$n2 set Y_ 2224
$n2 set Z_ 0.0
$ns initial_node_pos $n2 80
set n3 [$ns node]
$n3 set X_ 2795
$n3 set Y_ 2042
$n3 set Z_ 0.0
$ns initial_node_pos $n3 80
set n4 [$ns node]
$n4 set X_ 3093
$n4 set Y_ 2040
$n4 set Z_ 0.0
$ns initial_node_pos $n4 80
set n5 [$ns node]
$n5 set X_ 2950
$n5 set Y_ 1952
$n5 set Z_ 0.0
$ns initial_node_pos $n5 80
set n6 [$ns node]
$n6 set X_ 3320
$n6 set Y_ 1974
$n6 set Z_ 0.0
$ns initial_node_pos $n6 80
set n7 [$ns node]
$n7 set X_ 3520
$n7 set Y_ 2064
$n7 set Z_ 0.0
$ns initial_node_pos $n7 80
set n8 [$ns node]
$n8 set X_ 3516
$n8 set Y_ 2280
$n8 set Z_ 0.0
$ns initial_node_pos $n8 80
set n9 [$ns node]
$n9 set X_ 3696
$n9 set Y_ 2396
$n9 set Z_ 0.0
$ns initial_node_pos $n9 80
set n10 [$ns node]
$n10 set X_ 3884
$n10 set Y_ 2286
$n10 set Z_ 0.0
$ns initial_node_pos $n10 80
set n11 [$ns node]
$n11 set X_ 3888
$n11 set Y_ 2066
$n11 set Z_ 0.0
$ns initial_node_pos $n11 80
set n12 [$ns node]
$n12 set X_ 3720
$n12 set Y_ 1968
$n12 set Z_ 0.0
$ns initial_node_pos $n12 80
set n13 [$ns node]
$n13 set X_ 3320
$n13 set Y_ 1758
$n13 set Z_ 0.0
$ns initial_node_pos $n13 80
set n14 [$ns node]
$n14 set X_ 3162
$n14 set Y_ 1586
$n14 set Z_ 0.0
$ns initial_node_pos $n14 80
set n15 [$ns node]
$n15 set X_ 3484
$n15 set Y_ 1588
$n15 set Z_ 0.0
$ns initial_node_pos $n15 80
set n16 [$ns node]
$n16 set X_ 3165
$n16 set Y_ 1370
$n16 set Z_ 0.0
$ns initial_node_pos $n16 80
set n17 [$ns node]
$n17 set X_ 3488
$n17 set Y_ 1356
$n17 set Z_ 0.0
$ns initial_node_pos $n17 80
set n18 [$ns node]
$n18 set X_ 3335
$n18 set Y_ 1210
$n18 set Z_ 0.0
$ns initial_node_pos $n18 80

$ns at 0.0 "$n0 add-mark m1 blue circle"
$ns at 0.0 "$n1 add-mark m1 blue circle"
$ns at 0.0 "$n2 add-mark m1 blue circle"
$ns at 0.0 "$n3 add-mark m1 blue circle"
$ns at 0.0 "$n4 add-mark m1 blue circle"
$ns at 0.0 "$n5 add-mark m1 blue circle"
$ns at 0.0 "$n6 add-mark m1 blue circle"
$ns at 0.0 "$n7 add-mark m1 blue circle"
$ns at 0.0 "$n8 add-mark m1 blue circle"
$ns at 0.0 "$n9 add-mark m1 blue circle"
$ns at 0.0 "$n10 add-mark m1 blue circle"
$ns at 0.0 "$n11 add-mark m1 blue circle"
$ns at 0.0 "$n12 add-mark m1 blue circle"
$ns at 0.0 "$n13 add-mark m1 blue circle"
$ns at 0.0 "$n14 add-mark m1 blue circle"
$ns at 0.0 "$n15 add-mark m1 blue circle"
$ns at 0.0 "$n16 add-mark m1 blue circle"
$ns at 0.0 "$n17 add-mark m1 blue circle"
$ns at 0.0 "$n18 add-mark m1 blue circle"

$n2 color "red"
$n15 color "red"
$n12 color "red"
$ns at 3.8 "$n2 color red"
$ns at 6.0 "$n15 color red"
$ns at 6.2 "$n12 color red"

$n2 color "blue"
$n15 color "blue"
$n12 color "blue"
$ns at 6.5 "$n2 color blue"
$ns at 13.2 "$n15 color blue"
$ns at 10.8 "$n12 color blue"


$ns at 0.0 "$n1 label SOURCE"
$ns at 0.0 "$n6 label SINK"
$ns at 0.0 "$n17 label SOURCE"
$ns at 0.0 "$n11 label SOURCE"
$ns at 3.8 "$n2 label CUT"
$ns at 6.0 "$n15 label CUT"
$ns at 6.2 "$n12 label CUT"
$ns at 6.5 "$n2 label JOIN"
$ns at 13.2 "$n15 label JOIN"
$ns at 10.8 "$n12 label JOIN"

#===================================
#        Generate movement          
#===================================
$ns at 2 " $n2 setdest 3227 2347 50 " 
$ns at 4 " $n2 setdest 3090 2224 50 " 
$ns at 5 " $n12 setdest 3700 1826 50 " 
$ns at 8 " $n12 setdest 3720 1968 50 " 
$ns at 5 " $n15 setdest 3650 1600 50 " 
$ns at 9 " $n15 setdest 3484 1588 50 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink4 [new Agent/TCPSink]
$ns attach-agent $n6 $sink4
$ns connect $tcp0 $sink4
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n11 $tcp1
set sink5 [new Agent/TCPSink]
$ns attach-agent $n6 $sink5
$ns connect $tcp1 $sink5
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n17 $tcp2
set sink6 [new Agent/TCPSink]
$ns attach-agent $n6 $sink6
$ns connect $tcp2 $sink6
$tcp2 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.1 "$ftp0 start"
$ns at 15.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 2.0 "$ftp1 start"
$ns at 15.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 3.0 "$ftp2 start"
$ns at 15.0 "$ftp2 stop"

proc record {} {
global sink4 sink5 sink6
global f0 f1 f2 
set ns [Simulator instance]
set time 0.5
set bw0 [$sink4 set bytes_]
set bw1 [$sink5 set bytes_]
set bw2 [$sink6 set bytes_]

set now [$ns now]
puts $f0 "$now [expr $bw0/$time*8/1000000]"
puts $f1 "$now [expr $bw1/$time*8/1000000]"
puts $f2 "$now [expr $bw2/$time*8/1000000]"

$sink4 set bytes_ 0
$sink5 set bytes_ 0
$sink6 set bytes_ 0


$ns at [expr $now+$time] "record"
}

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
set f0 [open out0.tr w]
set f1 [open out1.tr w]
set f2 [open out2.tr w]


proc finish {} {
    global f0 f1 f2 
 
close $f0 
close $f1 
close $f2 

exec xgraph out0.tr out1.tr out2.tr -geometry 800x400 &
exec nam out.nam &
exit 0
    #global ns tracefile 
    #$ns flush-trace
    #close $tracefile
    #close $namfile
    #exec nam out.nam &
    #exec xgraph out.tr -geometry 800x400 &
    #exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns at 0.0 "record"
$ns at 3.8 "$ns trace-annotate \"Cut detected at node 2\""
$ns at 6.0 "$ns trace-annotate \"Cut detected at node 15\""
$ns at 6.2 "$ns trace-annotate \"Cut detected at node 12\""
$ns at 6.5 "$ns trace-annotate \"node 2 joined\""
$ns at 10.8 "$ns trace-annotate \"node 12 joined\""
$ns at 13.2 "$ns trace-annotate \"node 15 joined\""
$ns run

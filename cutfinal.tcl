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
set val(ifqlen) 100                         ;# max packet in ifq
set val(nn)     7                          ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1298                      ;# X dimension of topography
set val(y)      694                      ;# Y dimension of topography
set val(stop)   10.0                         ;# time of simulation end

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
#Create 7 nodes
set n0 [$ns node]
$n0 set X_ 1198
$n0 set Y_ 402
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
$ns at 0.0 "$n0 add-mark m1 red circle"
$ns at 0.0 "$n0 label BASE-STATION"

set n1 [$ns node]
$n1 set X_ 1010
$n1 set Y_ 400
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
$ns at 0.0 "$n1 add-mark m1 green circle"
$ns at 0.0 "$n1 label CLUSTER-HEAD"


set n2 [$ns node]
$n2 set X_ 973
$n2 set Y_ 594
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
$ns at 0.0 "$n2 add-mark m1 blue circle"

set n3 [$ns node]
$n3 set X_ 804
$n3 set Y_ 400
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
$ns at 0.0 "$n3 add-mark m1 blue circle"

set n4 [$ns node]
$n4 set X_ 954
$n4 set Y_ 244
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
$ns at 0.0 "$n4 add-mark m1 blue circle"

set n5 [$ns node]
$n5 set X_ 712
$n5 set Y_ 519
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
$ns at 0.0 "$n5 add-mark m1 blue circle"

set n6 [$ns node]
$n6 set X_ 744
$n6 set Y_ 264
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
$ns at 0.0 "$n6 add-mark m1 blue circle"
#===================================
#        Generate movement          
#===================================
$ns at 2.5 " $n2 setdest 866 509 70 " 
$ns at 2 " $n3 setdest 481 496 70 " 
$ns at 5 " $n3 setdest 887 272 70 " 
$ns at 5 " $n4 setdest 606 402 70 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink6 [new Agent/TCPSink]
$ns attach-agent $n1 $sink6
$ns connect $tcp0 $sink6
$tcp0 set packetSize_ 1000


#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink7 [new Agent/TCPSink]
$ns attach-agent $n2 $sink7
$ns connect $tcp1 $sink7
$tcp1 set packetSize_ 1000


#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink8 [new Agent/TCPSink]
$ns attach-agent $n5 $sink8
$ns connect $tcp2 $sink8
$tcp2 set packetSize_ 1000

#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n1 $tcp3
set sink9 [new Agent/TCPSink]
$ns attach-agent $n3 $sink9
$ns connect $tcp3 $sink9
$tcp3 set packetSize_ 1000

#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n1 $tcp4
set sink10 [new Agent/TCPSink]
$ns attach-agent $n6 $sink10
$ns connect $tcp4 $sink10
$tcp4 set packetSize_ 1000

#Setup a TCP connection
set tcp5 [new Agent/TCP]
$ns attach-agent $n1 $tcp5
set sink11 [new Agent/TCPSink]
$ns attach-agent $n4 $sink11
$ns connect $tcp5 $sink11
$tcp5 set packetSize_ 1000


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 9.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp4
$ns at 1.0 "$ftp1 start"
$ns at 9.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp5
$ns at 1.0 "$ftp2 start"
$ns at 9.0 "$ftp2 stop"

#Setup a FTP Application over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp1
$ns at 1.0 "$ftp3 start"
$ns at 9.0 "$ftp3 stop"

#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp2
$ns at 1.0 "$ftp4 start"
$ns at 9.0 "$ftp4 stop"

#Setup a FTP Application over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp3
$ns at 1.0 "$ftp5 start"
$ns at 9.0 "$ftp5 stop"

proc record {} {
global sink6 sink7 sink8 sink9 sink10 sink11 f0 f1 f2 f3 f4 f5
set ns [Simulator instance]
set time 0.5
set bw0 [$sink6 set bytes_]
set bw1 [$sink7 set bytes_]
set bw2 [$sink8 set bytes_]
set bw3 [$sink9 set bytes_]
set bw4 [$sink10 set bytes_]
set bw5 [$sink11 set bytes_]

set now [$ns now]
puts $f0 "$now [expr $bw0/$time*8/1000000]"
puts $f1 "$now [expr $bw1/$time*8/1000000]"
puts $f2 "$now [expr $bw2/$time*8/1000000]"
puts $f3 "$now [expr $bw3/$time*8/1000000]"
puts $f4 "$now [expr $bw4/$time*8/1000000]"
puts $f5 "$now [expr $bw5/$time*8/1000000]"

$sink6 set bytes_ 0
$sink7 set bytes_ 0
$sink8 set bytes_ 0
$sink9 set bytes_ 0
$sink10 set bytes_ 0
$sink11 set bytes_ 0

$ns at [expr $now+$time] "record"
}

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure

set f0 [open out0.tr w]
set f1 [open out1.tr w]
set f2 [open out2.tr w]
set f3 [open out4.tr w]
set f4 [open out5.tr w]
set f5 [open out6.tr w]

proc finish {} {
    global f0 f1 f2 
    global f3 f4 f5 
close $f0 
close $f1 
close $f2 
close $f3 
close $f4
close $f5
exec xgraph out0.tr out1.tr out2.tr out3.tr out4.tr out5.tr -geometry 800x400 &
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
$ns at 0.0 "record"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns at 2.66 "$ns trace-annotate \"Cut detected at node 3\""
$ns at 8.01 "$ns trace-annotate \"Cut detected at node 4\""
$ns run

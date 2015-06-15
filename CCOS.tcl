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
set val(nn)     7                          ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1010                      ;# X dimension of topography
set val(y)      613                      ;# Y dimension of topography
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
$n0 set X_ 285
$n0 set Y_ 365
$n0 set Z_ 0.0
$ns initial_node_pos $n0 30
set n1 [$ns node]
$n1 set X_ 509
$n1 set Y_ 513
$n1 set Z_ 0.0
$ns initial_node_pos $n1 30
set n2 [$ns node]
$n2 set X_ 692
$n2 set Y_ 446
$n2 set Z_ 0.0
$ns initial_node_pos $n2 30
set n3 [$ns node]
$n3 set X_ 910
$n3 set Y_ 359
$n3 set Z_ 0.0
$ns initial_node_pos $n3 30
set n4 [$ns node]
$n4 set X_ 796
$n4 set Y_ 174
$n4 set Z_ 0.0
$ns initial_node_pos $n4 30
set n5 [$ns node]
$n5 set X_ 576
$n5 set Y_ 155
$n5 set Z_ 0.0
$ns initial_node_pos $n5 30
set n6 [$ns node]
$n6 set X_ 366
$n6 set Y_ 184
$n6 set Z_ 0.0
$ns initial_node_pos $n6 30

$ns at 0.0 "$n0 label \"Sender\""
$ns at 4.5 "$n5 label \"CUT\""
$ns at 0.0 "$n3 label \"RECEIVER\""

$ns at 0.0 "$n0 add-mark m1 blue square"
$ns at 0.0 "$n1 add-mark m1 blue circle"
$ns at 0.0 "$n2 add-mark m1 blue circle"
$ns at 0.0 "$n3 add-mark m1 blue square"
$ns at 0.0 "$n4 add-mark m1 blue circle"
$ns at 0.0 "$n5 add-mark m1 blue circle"
$ns at 0.0 "$n6 add-mark m1 blue circle"
$n5 color "red"
$ns at 4.5 "$n5 color red"
#$ns at 4.3 "$n5 add-mark m2 red circle"

#===================================
#        Generate movement          
#===================================
$ns at 5.0 " $n1 setdest 461 465 100 " 
$ns at 5.5 " $n6 setdest 360 104 90 "


#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n0 $tcp2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n5 $sink3
$ns connect $tcp2 $sink3
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp5 [new Agent/TCP]
$ns attach-agent $n0 $tcp5
set sink4 [new Agent/TCPSink]
$ns attach-agent $n3 $sink4
$ns connect $tcp5 $sink4
$tcp5 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over TCP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $tcp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.5Mb
$cbr0 set random_ null
$ns at 0.5 "$cbr0 start"
$ns at 3.9.0 "$cbr0 stop"

#Setup a CBR Application over TCP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $tcp2
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.5Mb
$cbr1 set random_ null
$ns at 4.0 "$cbr1 start"
$ns at 5.5 "$cbr1 stop"

#Setup a CBR Application over TCP connection
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $tcp5
$cbr2 set packetSize_ 1000
$cbr2 set rate_ 1.5Mb
$cbr2 set random_ null
$ns at 6.5 "$cbr2 start"
$ns at 10.0 "$cbr2 stop"

#=================================
#             Record Procedure
#=================================

proc record {} {
global sink1 f0
set ns [Simulator instance]
set time 0.5
set bw0 [$sink1 set bytes_]


set now [$ns now]
puts $f0 "$now [expr $bw0/$time*8/1000]"

$sink1 set bytes_ 0



$ns at [expr $now+$time] "record"
}


set f0 [open attack.tr w]


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    #global ns tracefile namfile
    #$ns flush-trace
    #close $tracefile
    #close $namfile
    
    exec nam out.nam &
     global f0 
    close $f0
    
   
    exec xgraph attack.tr -geometry 800x400 &
    exit 0
}
   
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns at 0.0 "record"
$ns at 4.5 "$ns trace-annotate \"Cut detected at node 5\""
$ns at 7.0 "$ns trace-annotate \"Alternate Path \""
$ns run

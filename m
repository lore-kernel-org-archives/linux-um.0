Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVU1Z-0002r9-OM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 08:21:25 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IVU1N-0004OU-5B
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 08:20:58 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 12 Sep 2007 17:20:35 +0200
References: <611320.84682.qm@web25215.mail.ukl.yahoo.com>
	<46D2F3F2.5070906@cttc.es>
In-Reply-To: <46D2F3F2.5070906@cttc.es>
MIME-Version: 1.0
Message-Id: <200709121720.39717.blaisorblade@yahoo.it>
Subject: [uml-devel] Request for enhancement: UML management tools / VNUML
	(was: Re: Question regarding new versions of bb/bs guest UML patches)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1374764280=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?utf-8?q?Ferm=C3=ADn_Gal=C3=A1n_M=C3=A1rquez?= <fermin.galan@cttc.es>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: David =?utf-8?q?Fern=C3=A1ndez?= <david@dit.upm.es>

--===============1374764280==
Content-Type: multipart/signed; boundary="nextPart2870652.F1YJ1pkitW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2870652.F1YJ1pkitW
Content-Type: multipart/mixed;
  boundary="Boundary-01=_DPA6GSy7Mfi7thD"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_DPA6GSy7Mfi7thD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On luned=EC 27 agosto 2007, Ferm=EDn Gal=E1n M=E1rquez wrote:
> Dear Paolo,

> First of all, thank you very much for your information regarding the
> status of bb/bs patches and mconsole exec functionality. That
> information will be very useful for us in the generation of new UML
> kernels for the VNUML Project!

>  > I remember you around the mailing lists, but I did not know you
>  > developed VNUML - I read about it in a Gentoo howto (when I used
>  > Gentoo, long time ago).
>
> The basic idea of VNUML is that the user specifies what network topology
> he wants in a simple XML file, and then runs a Perl program (the VNUML
> parser) that reads that specification and bring it to live in the
> physical host. In these XML files, each UML vm is defined by a <vm> tag,
> like in the following example fragment:
>
> <vm name=3D"uml2">
> <filesystem
> type=3D"cow">/usr/share/vnuml/filesystems/root_fs_tutorial</filesystem>
>      <kernel>/usr/share/vnuml/kernels/linux</kernel>
>      <if id=3D"1" net=3D"Net0">
>        <ipv4>10.0.0.2</ipv4>
>      </if>
>      <route type=3D"ipv4" gw=3D"10.0.0.3">default</route>
> </vm>
>
> So, the definition of virtual machine scenarios is highly simplified for
> final users (e.g., they don't have to know the vmlinux binary complex
> switches and arguments or filesystem tuning, the VNUML parser will deal
> with that). Without VNUML, we found that the definition of complex
> topologies (i.e., a lot of UML vms with arbitrary connections between
> them) launching UML and uml_switches "by hand" was very complex.
>
> This is a very brief and basic introduction to VNUML, but you will find
> a lot of information in the project website
> (http://www.dit.upm.es/vnuml). Although I understand that you maybe are
> very busy :), you could have a look to the Tutorial
> (http://www.dit.upm.es/vnumlwiki/index.php/Tutorial) to get a "feeling"
> of what VNUML can offer to users trying to do complicated things in
> UML-based networking. In addition, the Examples section
> (http://www.dit.upm.es/vnumlwiki/index.php/Allexamples) can show you
> what kind of networking scenarios can be build with the tool.
>
>  > And I was also curious whether you had better
>  > startup tools than mainstream (running directly the vmlinux binary is
>  > uncomfortable, as is resizing an UBD image by hand, while for instance
>  > Xen has various useful management tools).
>
> I'd like to know what you refer by "startup tools in the *mainstream*"
> (maybe a name or link could clarify) because of, although I know several
> tools for UML management (like the ones in
> http://uml.jfdi.org/uml/Wiki.jsp?page=3DTools) I didn't know that any of
> them belongs to the UML mainstream. As far as I know, the UML project is
> very focused on the UML kernel issues but not in the "external"
> management of vms built with those kernels.

Indeed, there are no tools - I should have said there is no standard=20
management tool bundled into uml-utils, while there should be one.

I've also thought to NetKit, an Italian project (from other people, I'm not=
=20
involved with it) which has similar aims as your project.

In both cases, I haven't had the time to do anything else than give a=20
suggestion to other developers.

> Regarding the specific issues you mention:
>
> - "running directly the vmlinux binary is uncomfortable". VNUML solves
> this problems using XML (which I think is much more comfortable for
> users, due to its simple, structured and descriptive nature).
>
> - "resizing an UBD image". It is not part of VNUML operation, but we
> have developed tools and procedures to do so:
> http://www.dit.upm.es/vnumlwiki/index.php/Resize-rootfs.
>
> - "Xen has various useful management tools". Tools like the xm command
> make Xen virtual machine (actually domains, in Xen terms) management
> quite easy. In some sense, VNUML could be seen as a similar management
> tool, although the approach is quite different, because of the "unit of
> management" for (the current) VNUML is the network scenario as a whole
> (i.e., all the vms and the virtual network they conform), while with xm
> the unit of management are individual virtual machines. However, we are
> considering to evolve the VNUML approach in order to include a finer
> per-vm management, much like xm does.

That would be very good, and a big step in the direction I mean.
Personally, I've evolved a lot an old script packaged with some tool for UM=
L=20
root-fs creation, maybe UmlBuilder - I've even polished it a bit to=20
eventually publish it.

I'm attaching it to this mail with a sample commented configuration.

I also had started writing a tool to manage automatically creation and resi=
ze=20
of UBD/COW files or LVM/DM logical volumes, over LVM or over physical=20
partitions (including using the DM snapshot feature in place of COW files).=
=20
But time finished and the project became unmanageable (I used Perl and the=
=20
more the code grew the more I couldn't stand its messiness (even if it was=
=20
just 300 lines long).

>  > Can you help us about this?
>
> I'd be very pleased to help you, in the extends of my availability
> (unfortunately, not as much a I like :) and skills (although I'm the
> VNUML main developers, much of the UML technology stills being a mystery
> to me, specially the pieces that lay in the kernel space). Are you
> thinking in a particular idea/plan/issue? Maybe having a look to VNUML
> as I suggest above may help to get an idea of what VNUML strong points
> could be interesting for you. Of course, don't hesitate to ask any
> question if you need to know some specific detail.

> Best regards,


=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-01=_DPA6GSy7Mfi7thD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="Sarge-64.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Sarge-64.conf"

#Native 64-bit image.
unset emul

--Boundary-01=_DPA6GSy7Mfi7thD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="uml.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uml.conf"

## UML configuration settings
## This must be a well-formed bash script. So
##  a =3D b=20
##is invalid, while
##  a=3Db
##is valid.
##
## Commented settings are mostly the default ones.
#
#Network {{{
## netmode=3D suidtap | pretap | daemon
#
#netmode=3Dsuidtap

#
## If using uml_switch, i.e. netmode=3Ddaemon, you can specify the socket
## location. Otherwise, the below default is used.
#
#socket=3D/tmp/uml.ctl
#
# On Debian, you must specify a different location to be specified, when us=
ing
# the uml_switch binary shipped with Debian. If you forget this, network wi=
ll
# still work with Debian UML binaries, but not with anything else.
#
#socket=3D/var/run/uml-utilities/uml_switch.ctl

#
## host interface to determine tap endpoint from. We prefer to get the host=
 IP
## from /etc/hosts on the host, by searching hostname.
#
#hostiface=3D"eth0"

## Additional virtual Ethernet interfaces to configure. Default none.
#extranet=3D""
#
#The below example is for pcap networking, i.e. for sniffing host traffic f=
rom
#inside UML.
#However, you'd better hotplug such an interface in, probably.
#
#extranet=3D"eth1=3Dpcap,eth0,tcp,promisc"

## If you want to use kernel level configuration, i.e. ip=3D$ip, set the fo=
llowing
## to yes. Note that you need to enable CONFIG_IP_PNP in the guest kernel to
## make this work, and probably you'll get MAC conflicts this way, so you'll
## need to manually specify a MAC address.
#
#kernel_ip_config=3Dno

#}}} Network

# the file being used for the root filesystem
#rootfs=3D"$name.rootfs"
rootfs=3D"Root_images/$name.rootfs"

# the file being used for the swap space
#swapFile=3D"$name.swapfs"
swapFile=3D"Swap/$name.swapfs"

## Additional UBD disks to configure. Default none.
#extrafs=3D""
extrafs=3D"ubd1=3DRoot_images/UmlUbdSpace.fs"

# Whether to remove the swap cow file. By default yes.
#clean_swap=3Dyes

#useCow =3D yes | dm | no
#default:
#useCow=3Dno
useCow=3Dyes
#if useCow =3D dm, then /dev/mapper/${dm_prefix}${rootfs}.cow is the name u=
sed.

#Prefix for DM volume name, to prepend to instance name.
#Mostly in case the snapshot is created using LVM rather than raw DM
#dm_prefix=3Dusbdisk-

## Memory size.
memsize=3D"32m"
#memsize=3D"128m"
TMP=3D/tmp

#Custom screen options. Default none.
screenOpts=3D"-h 500"

#Save a copy of UML output to a file? Default no.
#doLog=3Dno
#doLog=3Dyes

#Where to save this log
#logFile=3D"uml-$name-log"
logFile=3D"traces/uml-$name-log"
# any extra arguments you always want supplied
#sound=3D"dsp=3D/dev/dsp mixer=3D/dev/mixer"
sound=3D""

#args=3D"$sound con=3Dxterm con0=3Dfd:3 xterm=3Dkonsole 3>uml-$name-log"
args=3D"$sound con=3Dxterm con0=3Dfd:0,fd:1 xterm=3D$(which konsole)"

#args=3D"$sound con0=3Dfd:0,fd:1 con=3Dxterm xterm=3Dkonsole

# If running on a x86-64 distribution, you may need to use the
# compatibility environment provided by the distro, which name may vary
# depending on which distro you use.
# Examples are linux32 on SuSE and Gentoo, setarch i386 or simply i386 on
# Fedora.
#=20
# Note that the script will clear this if it detects being in a 32-bit
# environment (detection done through uname).
#=20
# This was used under Fedora Core on x86-64.
#emul=3Di386
#emul=3Dlinux32

#emul=3D"linux32 --3gb"
#emul=3D"linux32"
#
# vim: set fdm=3Dmarker:

--Boundary-01=_DPA6GSy7Mfi7thD
Content-Type: application/x-shellscript;
  name="uml-control"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-control"

#!/bin/sh
#
# Copyright (C) 2004,2005 Paolo 'Blaisorblade' Giarrusso
# Licensed under the GPL
#
# Derived from this one from the UmlBuilder project, adapted to pass to the Uml
# the hostname and the IP to take got from command line:
# $Id: starttemplate,v 1.16.2.1 2002/11/27 07:55:56 rogerb Exp $

# Usage {{{
usage() {
	echo "`basename $scriptName` UmlHostname
	(start|stop|console|reboot|status|kill|mount|umount) [-s signal] [-v
	version] [--noscreen] [UmlKernelParams]"
	echo "--noscreen  avoids starting Uml under screen"
        echo "UmlHostname will be searched in the host /etc/hosts file to get the Uml's IP address. Then the Uml
                          will search it back in its /etc/hosts file to get its hostname"
	echo "drystart    pretends to start new session, and print cmd line (useful to get command line for gdb)"
	echo "gdb         starts it under gdb (modifies .gdbinit)"
	echo "start       starts new session"
	echo "stop        stops current session (hard halt) - safer to use"
	echo "            init 0 inside session"
	echo "reboot      reboots current session (hard reboot) - safer to use"
	echo "            init 6 inside session"
	echo "cad         sends ctrl-alt-delete"
	echo "console     starts mconsole"
	echo "status      current status"
	echo "kill        kill -TERM the uml session (or -signal)"
	echo "mount       mounts filesystems as loopback on mnt,  you must be root"
	echo "umount      unmounts the above"
	echo "du          shows actual disk space usage"
	#echo "mkinitrd    creates initial ramdisk"
	#echo "installmods installs current modules into your uml root filesystem"
}
# }}}

### Argument parsing section {{{
###

scriptName=$0
# Used for umid (UML id) and for IP.
name=$1

if [ -z "$name" ]; then
  usage
  exit 1
fi

if echo $name | grep -q /; then
	echo "Invalid name supplied, / char not admitted"
	exit 1
fi
shift
command=$1
if [ -z "$command" ]; then
  usage
  exit 1
fi

shift

if [ "$1" = "-v" ]; then
  linVersion=$2
  shift; shift;
fi

signal=TERM
if [ "$1" = "-s" ]; then
  signal=$2
  shift; shift;
fi

opt_noscreen=0
if [ "$1" = "--noscreen" ]; then
  opt_noscreen=1
  shift
fi

# }}}
###
### We change directory to where this script is located
###

d=`dirname $scriptName`; cd $d; unset d

###
### Defaults
###

# the file being used for the root filesystem
rootfs="$name.rootfs"
swapFile="$name.swapfs"
memsize="32m"
args=""
logFile="uml-$name-log"

#### whether or not to use initial ramdisks
####useinitrd="false"

###
### end configuraction section }}}
###

### Get default settings

[ -f uml.conf ] && . uml.conf
[ -f $name.conf ] && . $name.conf

[ -z "$clean_swap" ] && clean_swap="yes"
[ "$clean_swap" = "yes" ] && rm -f "$swapFile.cow"

# and what is used for swap. We use a COW to clean it each time.
[ -z "$swap" ] && swap="ubd7=$swapFile.cow,$swapFile"

### figure out host ip address {{{
###

ipfromname() {
  #grep -v '^#' /etc/hosts|grep "$1"|awk '{print $1; exit}'
  awk '/^#/ {next;} /'"$1"'/ {print $1; exit}' /etc/hosts
}

[ -z "$hostip" ] && hostip=$(ipfromname $(hostname))
if [ -z "$hostip" -o "$hostip" = "127.0.0.1" ]; then
	[ -z "$hostiface" ] && hostiface="eth0"

	hostip=`LANG="C" LC_ALL="C" ifconfig $hostiface | grep 'inet addr:' | sed 's/.*inet addr:\([0-9.]*\).*/\1/'`
fi

umlip=$(ipfromname $name)
#}}}

### Network settings {{{
###

# base networking parameter
[ -z "$socket" ] && socket=/tmp/uml.ctl

if [ -z "$netmode" ]; then
	netmode=suidtap
	[ ! -u `which uml_net` ] && netmode=pretap
	[ -f "$socket" ] && netmode=daemon
fi

PATH=/sbin:/usr/sbin:$PATH
case "$netmode" in
	suidtap)
	net="eth0=tuntap,,,$hostip"
	;;
	pretap)
	net="eth0=tuntap,tap0"
	;;
	daemon)
	net="eth0=daemon"
	;;
esac

net="$net $extranet"

if [ "$kernel_ip_config" = "yes" ]; then
	uml_ip_arg="ip=$umlip"
else
	uml_ip_arg="UML_IP=$umlip"
fi

#XXX: not yet implemented in umlutils.
uml_ip_arg="$uml_ip_arg UML_HOSTNAME=$name"
#}}}

### specify filesystems {{{

if [ "$useCow" = yes ]; then
	fs="ubd0=$rootfs.cow,$rootfs"
elif [ "$useCow" = dm ]; then
	fs="ubd0s=/dev/mapper/${dm_prefix}${rootfs}.cow"
else
	fs="ubd0s=$rootfs"
fi
fs=" $fs rootfs=/dev/ubda $extrafs"
#}}}

if uname -m|grep -q '^i.86$'; then
	unset emul
fi

### Look for uml binary {{{

PATH=.:$PATH

if [ -x $name ]; then
  linux=$name
elif [ -x linux$linVersion ]; then
  linux=linux$linVersion
elif [ -x "$linVersion" ]; then
  linux=$linVersion
elif [ -n "$linVersion" ]; then
  echo "Required linux version not found" >&2
  exit 1
elif [ -x linux ]; then
  linux=linux
elif [ "$command" = "start" ]; then
  echo "No linux binary found" >&2
  exit 1
fi
#}}}


### figure out display {{{
###

disp="$DISPLAY"
if [ -n "$disp" ]
then 
    disp="`echo $disp | sed 's/^unix:\(.*\)/:\1/'`"
    if [ `expr "$disp" : ':.*'` -ne 0 ] ; then disp="$hostip$disp" ; fi
fi

#}}}

if [ "$doLog" = "yes" ]; then
	teepipe="2>&1|tee $logFile"
fi

# mconsole pipe is derived from mconsole name. We don't allow to override this.
mc=$name
mcp=$HOME/.uml/$mc/pid


### Process command {{{
###
case $command in
    drystart|start|gdb)
	####
	#### look for initial ramdisk
	####
	#
	#initrd=""
	#
	## override useinitrd parameter if $linux doesn't support them anyway
	#if [ `$linux --help | grep initrd | wc -l` -eq 0 ]
	#then
	#    useinitrd=false
	#fi

	#if $useinitrd
	#then
	#    if [ ! -f $initrdname ]
	#    then 
	#	$scriptName mkinitrd
	#	ec=$?
	#	if [ $ec -ne 0 -o ! -f $initrdname ]
	#	then
	#	    echo "Failed to create initial ramdisk.  You can turn off initrd support by"
	#	    echo "editing $scriptName.  Exit code was $ec."
	#	    exit $ec
	#	fi
	#    fi
	#    initrd="initrd=$initrdname"
	#fi
	#
	#if [ ! -f .mods-$umlversion ]
	#then
	#    $scriptName installmods
	#    ec=$?
	#    if [ $ec -ne 0 ] ; then exit $ec ; fi
	#fi

	# now get around to the business of actually running UML
	ux=""
	if [ "$disp" != "" -a "$umlip" != "" ]
	then
	    # Allow UML guest to access our X server (see doc note about security)
	    ux="UML_XDISPLAY=$disp"
	    xhost +$umlip
        fi

	export TMP

	screen_prepend="screen $screenOpts -S $name"
	#To avoid screen exiting!
	#screen_append="; exec bash"
	#To avoid screen exiting only when Uml fails!
	screen_append="|| exec bash"
	if [ "${opt_noscreen}" = "1" ]
	then
		unset screen_prepend screen_append
	fi
	base_cmd="$initrd umid="$name" $fs $swap mem=$memsize $net $ux $uml_ip_arg $args $@"
	lincommand="${screen_prepend} bash -c \"$emul $linux $base_cmd $teepipe ${screen_append}\""
	if [ "$command" = "start" ]; then
		eval exec $lincommand
	elif [ "$command" = "drystart" ]; then
		echo "$lincommand"
	elif [ "$command" = "gdb" ]; then
		echo "set args $base_cmd" > .gdbinit
		echo "break panic" >> .gdbinit
		echo "break main" >> .gdbinit
		echo "break printk" >> .gdbinit
		echo "handle SIGUSR1 noprint" >> .gdbinit
		exec gdb $linux
	fi
	;;
    stop)
	uml_mconsole "$mc" halt "$@"
	exit
	;;
    kill)
	if [ -f $mcp ]
	then
	    echo "Killing pid `cat $mcp`"
	    kill -$signal "`cat $mcp`"
	else
	    echo "Instance $name doesn't appear to be running"
	fi
        exit 
        ;;
    console|mconsole)
        exec uml_mconsole $mc "$@"
	;;
    cad|ctrl-alt-delete)
	exec uml_mconsole $mc cad "$@"
	;;
    reboot)
	uml_mconsole $mc reboot "$@"
	exit 
	;;
#    install)  # undocumented option used to install stuff originally
	#rm -f installfs/success
	#$linux rw umid="$name" $fs mem=64m ubd7=installfs $net root=/dev/ubd7 init=/uml_stage2install.py  $args $UMLBUILDERINSTALLARGS "$@"
	#if [ -f installfs/success ]
	#then
	    #exitcode=0
	    #echo "Install succeeded"
	#else
	    #echo "Install failed"
	    #exitcode=1
	#fi
	#rm -f installfs/opts.py 2>/dev/null # contains root password
#        find installfs -type d -print | xargs chmod 777 2>/dev/null
	#rm -rf installfs 2>/dev/null
	#if [ $exitcode = 0 ]
	#then $scriptName installmods ; $scriptName mkinitrd ; exit $? ; fi
	#exit $exitcode
	#;;
#    mkinitrd)
	#rm -f $initrdname
	#if $useinitrd
	#then
	    #echo "Creating new initial ramdisk"
	    #exec umlbuilder_miniroot "$@" --root $rootfs mkinitrd $initrdname
	#fi
	#exit 0
	#;;
#    installmods)
	#rm -f .mods-$umlversion
	#echo "Updating modules"
	#umlbuilder_miniroot "$@" --root $rootfs installmods
	#ec=$?
	#if [ $ec = 0 ]
	#then touch .mods-$umlversion ; fi
	#exit $ec
	#;;
    mount)
        mkdir -p $name.mnt
        mount $rootfs $name.mnt -o loop
        exit
        ;;
    umount)
        umount $name.mnt
        exit
        ;;
    status)
	pid=`cat $mcp`
        echo "pid is $pid"
	ps -ef | grep $pid | grep -v "grep $pid"
	echo
	uml_mconsole $mc version
	exit
	;;
    df|du)
	ls -lhs
	exit
	;;
    *)
    	usage
	exit 1
esac

# }}}
# vim: set fdm=marker fdc=2:

--Boundary-01=_DPA6GSy7Mfi7thD--

--nextPart2870652.F1YJ1pkitW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6APHqH9OHC+5NscRAod/AKCL2WQ4+7kXdKPoowI73ewZw7lenQCfVbLc
RWJaOFQqHp8u5y/Bs12Vy1I=
=z1lW
-----END PGP SIGNATURE-----

--nextPart2870652.F1YJ1pkitW--


--===============1374764280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1374764280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1374764280==--


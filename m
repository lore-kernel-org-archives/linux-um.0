Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxWxi-0007wM-GS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 13:23:10 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxWxg-0007gC-UT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 13:23:10 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i7IKN0ao003743
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 16:23:00 -0400 (EDT)
Message-ID: <4123BA9D.6080201@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <412227A4.6060005@enterasys.com>
In-Reply-To: <412227A4.6060005@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6410B4BEEAF9C75DCC56E2B3"
Subject: [uml-devel] No Bug Here: [Was: Expected SIGSTOP persists in
	2.4.26-3um ]
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Aug 2004 16:22:53 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6410B4BEEAF9C75DCC56E2B3
Content-Type: multipart/mixed; boundary="------------030404090700020108000904"

This is a multi-part message in MIME format.
--------------030404090700020108000904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I withdraw this error report against 2.4.26-3um
against any plain vanilla UML kernel for that matter.

I've launched 2.4.26-3um about 200 times (50 at once
even, with the script attached its easy to stress test!)
and never seen this in a kernel that we haven't modified
ourselves... still if anyone has any ideas....

Thanks for your patience.

D. Bahi wrote:
> launching UMLs with nice seems to aggravate this problem --
> but it also has been seen w/o adding that irritant.
> 
> status is 0x1c7f - which maps to 0x1c (SIGWINCH    28 right?)
> 
> here it is trying to panic and generates a segfault
> 
> #4  0x08051270 in main (argc=11, argv=0xbfffd3e4, envp=0xbfffd414) at 
> arch/um/main.c:148
> #3  0x080dd2f4 in linux_main (argc=11, argv=0xbfffd3e4) at um_arch.c:332
> #2  0x080d9154 in can_do_skas () at process.c:255
> #1  0x080d9058 in stop_ptraced_child (pid=21301, stack=0x40001000, 
> exitcode=1) at process.c:182
> #0  0x0805628c in panic (fmt=0x81c8080 "check_ptrace : child exited with 
> status 0x%x") at panic.c:67
> 
> values for locals and parameters in stop_ptraced_child are:
> 
> (gdb) print errno
> $1 = 0
> (gdb) print n
> $2 = -1073774592
> (gdb) print pid
> $3 = 21301
> (gdb) print status
> $4 = 7295
> (gdb) print exitcode
> $5 = 1
> (gdb) set radix 16
> (gdb) print status
> $6 = 0x1c7f
> (gdb) print n
> $7 = 0xbfff8000
> 
> also have seen:
> 
> 2.4.24-1um + reboot-signals
> 
>   Checking for the skas3 patch in the host...found
>   Checking for /proc/mm...found
>   CONFIG_HIGHMEM not enabled - physical memory shrunk to 499122176 bytes
>   Kernel virtual memory size shrunk to 32505856 bytes
>   capture_stack : Expected SIGSTOP, got status = 0x1c7f
> 
> 
> 2.4.26-3um
> 
>   Checking for the skas3 patch in the host...found
>   Checking for /proc/mm...found
>   capture_stack : Expected SIGSTOP, got status = 0x1c7f
> 
> 

-- 
Damn it! Morons don't learn until they die! -- Faye Valentine, _Cowboy Bebop, The 
Movie_.

--------------030404090700020108000904
Content-Type: text/plain;
 name="uml_launch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml_launch"

#!/bin/bash 

declare -i idx= first=1

rm -rf   /local/target0/umltest
mkdir -p /local/umltest/cow
mkdir -p /local/umltest/hostfs

if (( $# < 1 )); then
    idx=1
else
    idx=$1
fi

root="/local/dbahi/root_fs.rh-9-full"
swap="/local/dbahi/swap_fs.256"
pipe="/local/umltest/pipe"

linux="/view/dmerrill_linux/ccase/linux24/src/linux"

if [[ ! -x "${linux}" ]]; then
  echo -ne "${linux}\n\nnot found or not executable!!!!\n"
  exit
fi

pause=5
mem="128M"
nice="nice"
screen="screen -DmS"
xterm="xterm -e screen -r"
tunctl="tunctl -b -u $USER"

echo -ne "\n#  Will launch $idx UML(s)...\n#\n#"
echo -ne "\n#  Launching tunctl for tap interface with command:\n#"
echo -ne "\n#     ${tunctl}\n#\n#"

tapdev=$(${tunctl})

umlxcmd="/usr/bin/uml_switch -unix ${pipe} -tap ${tapdev}"
tunrm="tunctl -d ${tapdev}"

echo -ne "\n#  Launching uml_switch with command:\n#"
echo -ne "\n#     ${screen} uml_switch -t uml_switch ${umlxcmd}\n#\n#"
echo -ne "\n#  Attaching uml_switch with command:\n#"
echo -ne "\n#     ${xterm} uml_switch\n#\n#"

${screen} uml_switch -t uml_switch ${umlxcmd} &
${xterm} uml_switch &

cur=1
while (( $cur <= $idx )); do
    umid="uml_${cur}"
    mac=$(echo "ibase=10; obase=16; ${cur}" | bc)
    ubd0cow="/local/umltest/cow/ubd0_${cur}"
    ubd1cow="/local/umltest/cow/ubd1_${cur}"
    hfsdir="/local/umltest/hostfs/host_${cur}"
    eth="daemon,fe:fd:00:00:00:${mac},unix,${pipe}"

    cmd="${nice} ${linux} umid=${umid} ubd0=${ubd0cow},${root} ubd1=${ubd1cow},${swap} hostfs=${hfsdir} mem=${mem} eth0=${eth}"

    if (( $first > 0 )); then
        first=0
        echo -ne "\n#  Launching UML with commands like:\n#"
        echo -ne "\n#     ${screen} ${umid} -t ${umid} ${cmd}\n#\n#"
        echo -ne "\n#  Attaching UML with commands like:\n#"
        echo -ne "\n#     ${xterm} ${umid}\n#\n#"
        echo -ne "\n#  Use the following to shutdown:\n\n\n"
        echo -ne "pkill uml_switch\n\n"
    fi
    echo -ne "uml_mconsole ${umid} halt"

    mkdir -p ${hfsdir}
    ${screen} ${umid} -t ${umid} ${cmd} &
    ${xterm} ${umid} &

    if (( $cur < $idx )); then
        echo -ne "    # pausing .";
        slept=0
        while (( $slept < $pause )); do
            sleep 1
            echo -ne "."
            slept=$((slept + 1))
        done
    fi
    echo -ne "\n"
    cur=$((cur + 1))
done

echo -ne "\n$tunrm\n"

echo -ne "\n\n#  Done.\n"

--------------030404090700020108000904--

--------------enig6410B4BEEAF9C75DCC56E2B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBI7qi3XQ4zakZ3z4RAh8nAJ4gCjK0dKYC60xU6M/WSZk+GmY6bwCfSAGO
riw0ghulVkxsgaDU0DRUGDg=
=5W2x
-----END PGP SIGNATURE-----

--------------enig6410B4BEEAF9C75DCC56E2B3--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

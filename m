Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArILZ-0006f5-Rj
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:01:45 -0800
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1ArIKN-00049D-VE
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 07:00:32 -0800
From: Michael Koehne <kraehe@copyleft.de>
Subject: Re: [uml-devel] Which UPS simulator?
Message-ID: <20040212150023.GA32317@bakunin.copyleft.de>
References: <20040212052823.GA4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212052823.GA4203@erizo.shearer.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 16:00:23 +0100
To: Dan Shearer <dan@shearer.org>, user-mode-linux-devel@lists.sourceforge.net

Moin Dan Shearer,

  why UPS simulation ? I'm using normal mconsole cad feature to power
  down my UMLs. I only have to ensure that the inittab will trigger a
  halt with "ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -h now" instead
  of rebooting. I then have some helpfull scripts.

  /opt/uml/bin/uml is using screen :

#------------------------------------------------------------------------------
#!/bin/sh

[ $# = 1 ] || {
    echo usage: uml machine
    exit 0
    }
[ -f /opt/uml/$1/$1.config ] || {
    echo machine $1 not defined
    }

if [ -f /opt/uml/$1/$1.running ]
then
    screen -d -r $1
else
    screen -S $1 /opt/uml/bin/uml-start $1
fi
exit 0
#------------------------------------------------------------------------------
  
  /opt/uml/bin/uml-start does a filesystemcheck :

#------------------------------------------------------------------------------
#!/bin/sh

cd /opt/uml/

[ `whoami` != "root" ] && {
        echo "only root can use $0"
        exit 1
        }
[ $# != 1 ] && {
        echo "usage: $0 name"
        exit 0
        }
[ ! -f $1/$1.root.img ] && {
        echo "$1/$1.root.img not found"
        exit 0
        }
[ ! -f $1/$1.swap.img ] && {
        echo "$1/$1.swap.img not found"
        exit 0
        }
[ ! -f $1/$1.options ] && {
        echo "$1/$1.options not found"
        exit 0
        }
[ ! -f /opt/uml/$1/$1.linux ] && {
        echo "/opt/uml/$1/$1.linux not found"
        exit 0
        }
[ -f $1/$1.running ] && {
        echo "$1 already running"
        exit 0
        }

touch $1/$1.running

[ -d $1/$1.root.fs/lost+found ] && umount $1/$1.root.fs
[ -d $1/$1.work.fs/lost+found ] && umount $1/$1.work.fs

echo checking file systems :
[ -f $1/$1.root.img ] && e2fsck -y -f -v $1/$1.root.img
[ -f $1/$1.work.img ] && e2fsck -y -f -v $1/$1.work.img
echo done.

/opt/uml/$1/$1.linux `cat $1/$1.options`

# [ -d $1/$1.root.fs ] && mount -o loop $1/$1.root.img $1/$1.root.fs
# [ -d $1/$1.work.fs ] && mount -o loop $1/$1.work.img $1/$1.work.fs

rm -f $1/$1.running

exit 0
#------------------------------------------------------------------------------

  /opt/uml/bin/uml-stop will halt systems

#------------------------------------------------------------------------------
#!/bin/sh

cd /opt/uml

echo -n UML shutdown systems :

for s
do
    x=$s/$s.running
    if [ ! -f "$x" ] 
    then
        echo " no systems up."
        exit 0
    else
        echo -n " $s "
        echo cad | uml_mconsole $s 2>/dev/null >/dev/null
        echo -n ".";sleep 1
        echo -n ".";sleep 1
        echo -n ".";sleep 1
    fi
done

echo done.

echo -n UML waiting for systems :
while true
do
    for s
    do
	x=$s/$s.running
        if [ ! -f "$x" ] 
        then
            echo all systems down.
            exit 0
        else
            echo -n " $s "
        fi
    done
    echo -n ".";sleep 1
    echo -n ".";sleep 1
    echo -n ".";sleep 1
done
#------------------------------------------------------------------------------

  ask me for a complete shar.gz or tar.gz of my current UML environment :

  uml          uml-copydef      uml-gen      uml-start     uml-tunctl
  uml-bkup     uml-createfs     uml-mount    uml-startall  uml-umount
  uml-bkupall  uml-forward      uml-net      uml-stop      uml_switch
  uml-config   uml-forward-old  uml-running  uml-stopall
  uml-copyall  uml-fsck         uml-screen   uml-tap1

  each UML is defined by a small text config file, so a lot of UMLs
  can be managed in a simple way. Backups for virtual UML machines 
  and migration to other hosts is semiautomatic. e.g. noam is the
  site hosting www.copyleft.de and other domains :

#------------------------------------------------------------------------------
HOST="noam"
DOMAIN="copyleft.de"
MODULES=""

#ETH0OPT="tuntap,,,193.101.47.67"
ETH0BASE="193.101.47"
ETH0WORK="193.101.47.64"
ETH0GATE="193.101.47.65"
ETH0ADDR="193.101.47.67"
ETH0CAST="193.101.47.95"
ETH0MASK="255.255.255.224"

NAMESERVER="193.101.47.33"
PROXY="193.101.47.33:3128"

ROOT="/dev/ubd0"
SWAP="/dev/ubd1"
WORK="/dev/ubd2"

STORSIZE=64
SWAPSIZE=128
ROOTSIZE=256
WORKSIZE=2048
#------------------------------------------------------------------------------

  I recently reinstalled my Libretto laptop :
      Linux makhno 2.6.1-l5skas1 #1 Wed Feb 4 02:25:54 UTC 2004 i686 GNU/Linux
  All i had to do to to run noam on this machine was :

  ssh makhno mkdir -p /opt/uml/bin
  scp /opt/uml/bin/* makhno:/opt/uml/bin
  uml-copydef skel makhno
  uml-copydef noam makhno
  uml-bkup noam makhno
  ssh makhno
  export PATH=/opt/uml/bin:$PATH
  uml-net
  uml noam

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [uml-user] UML freezes at hdd-intensive processes
References: <36770.128.176.89.137.1109844107.squirrel@128.176.89.137>
	<200503111102.54214.rob@landley.net>
	<32921.83.129.31.196.1110575910.squirrel@83.129.31.196>
In-Reply-To: <32921.83.129.31.196.1110575910.squirrel@83.129.31.196>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0VgMC7cZx67dcZI"
Message-Id: <200503111554.12377.rob@landley.net>
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
Date: Fri, 11 Mar 2005 15:54:12 -0500
To: Oliver Baltz <info@OliverBaltz.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--Boundary-00=_0VgMC7cZx67dcZI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 11 March 2005 04:18 pm, Oliver Baltz wrote:
> Hi Rob,
>
> > Is it write-intensive, read-intensive, combination of both, or either
> > one?
>
> I think it is a combination of both: When installing just one single
> debian-package the UML often freezes :-(
>
> Is there an alternative to UBD?
>
> Oliver

Just for testing purposes, you could try hostfs and then loopback mount your 
block device.

I boot UML like this all the time, to borrow the parent's filesystem.  (It has 
a lot of downsides, and is slower than ubd, but it requires absolutely no 
setup):

./linux rootfstype=hostfs rootflags=/ rw init=/bin/sh mem=64M

Note that this works under an Xterm because you own /dev/console, but if 
you're running it from the console you either need to 
chown/chmod /dev/console or you need to be root.  I have a script that gets 
around that, lemme dig it up...  Attached.  You don't need anything _nearly_ 
that complicated, but I just thought I'd let you know what kind of abuse you 
can do with hostfs... :)

Rob

--Boundary-00=_0VgMC7cZx67dcZI
Content-Type: application/x-shellscript;
  name="mktools-umlsetup.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mktools-umlsetup.sh"

#!/bin/sh

# This script is run by the UML instance to set up the UML environment and
# pass control on to mktools-build.sh.  If you don't need User Mode Linux
# (I.E. you're running as root on a new enough kerenel), you can skip this
# script and run mktools-build.sh directly.

# Although we're running as root in the UML instance, UML shouldn't be running
# as root on the host system.  As a result, large chunks of our hostfs are
# effectively read only.  We can't write to the root directory, and we can't
# mknod or chown anywhere.  Also, the mounted synthetic filesystems (/proc
# and /dev/pts) refer to the parent kernel, not the one running our processes.

# To get around this we create a loopback mounted ext2 image, bind mount all
# the other directories from the real root dir into it (and duplicate all the
# symlinks, so we can rebuild under ourselves), mount the UML instance's proc
# and devpts into it, and chroot.

# This assumes we have a sane host system, where /home, /proc, and /dev/pts
# exist, and where /mktools.sh and /tools do not already exist.  Then again,
# we're assuming you've got a sane enough host system to compile the rest of
# the tools directory anyway.  (If you haven't, just grab a prepackaged tools
# and use that.)

# Note that sane is not the same thing as well-constructed.  For example,
# we use mount -n in case somebody is crazy enough to run this as root on an
# old system where /etc/mtab is not a symlink to /proc/mounts.


# First, replace /dev with a ramfs containing the dev entries we need.  (The
# permissions on things like /dev/console and /dev/loop0 are often wrong for
# us.)

mount -n -t ramfs /dev /dev &&
mknod -m 700 /dev/console c 5 1 &&
mknod -m 700 /dev/zero c 1 5 &&
mknod -m 700 /dev/loop0 b 7 0 &&
mkdir /dev/pts

function remount()
{
  echo "Creating ext2 image..." &&

  mount -n -t proc /proc /proc &&
  export PATH=/sbin:/usr/sbin:/bin:/usr/bin &&
  cd "$DIR/tmpdir" &&
  dd if=/dev/zero of=tools.img bs=8192 count=65536 &&
  mke2fs -F tools.img &&
  echo "Remounting parent system for chroot environment..." &&
  mkdir sub &&
  losetup /dev/loop0 tools.img &&
  mount -n -t ext2 /dev/loop0 sub &&
  cd sub &&
  for i in /*
  do
    i="${i:1}"
    if [ "$i" != "lost+found" ]
    then
      if [ -h "$i" ]
      then
        ln -s $(ls -l "$i" | sed 's/^.*-> //') "$i"
      elif [ -d "/$i" ]
      then
        mkdir "$i"
        mount -n -o bind "/$i" "$i"
      fi
    fi
  done
  if [ $? -ne 0 ]; then exit 1; fi
  mount -n -t devpts /dev/pts dev/pts &&
  # Now chroot and hand control off to next script
  chroot . /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin HOME=/root TERM=linux /bin/sh -c "cd $DIR;exec ./mktools-build.sh" &&
  # Create the tarball we went through this whole exercise to get.
  tar cvjf ../tools.tar.bz2 tools
  sync
  halt -f
}

remount </dev/console >/dev/console 2>/dev/console

--Boundary-00=_0VgMC7cZx67dcZI--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

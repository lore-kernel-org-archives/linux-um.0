Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cogyz-00068I-Me for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 03:48:13 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cogyx-0005Cz-SX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 03:48:13 -0800
Message-ID: <50806.80.203.0.208.1105530488.squirrel@80.203.0.208>
Subject: Re: [uml-devel] df -h and hostfs
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Wed, 12 Jan 2005 12:48:08 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

(ops, forgot reply-all)

df -h inside UML: (/etc/mtab is symlinked to /proc/mounts)

Filesystems           Size  Used Avail Use% Mounted on
rootfs                496M   11M  460M   3% /
/dev/root             496M   11M  460M   3% /
/dev/ubd/disc1/part1  187G  146G   33G  82% /a
a                     7.3G  6.2G  717M  90% /a/lost+found
/root/UML/a           7.3G  6.2G  717M  90% /a/lost+found


mount inside UML:

rootfs on / type rootfs (rw)
/dev/root on / tyoe ext3 (ro)
none on /dev/ type devfs (rw)
/dev/ubd/disc1/part1 on /a type ext2 (rw)
a on /a/lost+found type hostfs (rw)
noen on poroc type proc (rw,nodiratime)


df -h on host:

Filesystems           Size  Used Avail Use% Mounted on
/dev/hda2             7.3G  6.2G  717M  90% /
none                  126M     0  126M   0% /dev/shm
192.168.1.1:/var/home/stian
                      147G  104G   37G  75% /root/UML/a

mount on host

/dev/hda2 on / type xfs (rw,noatime)
none on /dev type devfs (rw)
none on /proc type proc (rw)
noen on /dev/shm type tmpfs (rw)
192.l68.1.1:/var/home/stian on /root/UML/a type nfs (rw,addr=192.168.1.1)


The problem is the nfs partition you can see, that is mounted inside UML
again as hostfs. (This setup is a recovery of a broken disk where I wanted
the cow layer when testing recoverytools and dumping out files they
found). The UML-kernel itself is 2.6.10-rc3-mm1 with the patch-set from
the web-pages dated back 1-2 weeks ago.


Stian




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

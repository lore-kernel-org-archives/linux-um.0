Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Con8K-0000Tc-4u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 10:22:16 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Con8J-0007wy-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 10:22:15 -0800
Message-ID: <52224.80.203.0.208.1105554129.squirrel@80.203.0.208>
In-Reply-To: <200501121833.03286.blaisorblade@yahoo.it>
References: <50806.80.203.0.208.1105530488.squirrel@80.203.0.208>
	<200501121833.03286.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 19:22:09 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, stian@nixia.no

>> df -h inside UML: (/etc/mtab is symlinked to /proc/mounts)
>
>> Filesystems           Size  Used Avail Use% Mounted on
>> rootfs                496M   11M  460M   3% /
>> /dev/root             496M   11M  460M   3% /
>> /dev/ubd/disc1/part1  187G  146G   33G  82% /a
>> a                     7.3G  6.2G  717M  90% /a/lost+found
>> /root/UML/a           7.3G  6.2G  717M  90% /a/lost+found
> What has happened here? Why there are two entries on the same mount point?
> One
> mount over the other?

I just used
mount /root/UML/a /a/lost+found -t hostfs
why should you need an -o ? The mount-point works, and everything inside
it looks like it should, and files I put into it appears as they should (I
used that directory, since the uml-filesystem is just banged together som
files from /bin so I could fix a disk, use /bin/sh as init for instance)
An those entries as what likes in /proc/mounts, since I don't have a
maintained /etc/mtab file in that filesystem. /etc/mtab is symlinked to
/proc/mounts

>> mount inside UML:
>
>> rootfs on / type rootfs (rw)
>> /dev/root on / tyoe ext3 (ro)
>> none on /dev/ type devfs (rw)
>> /dev/ubd/disc1/part1 on /a type ext2 (rw)
>> a on /a/lost+found type hostfs (rw)
>> noen on poroc type proc (rw,nodiratime)
>
> How did you mount that folder on /a/lost+found? You wanted, probably, to
> do:
> mount <whatever> > /a/lost+found -t hostfs -o /root/UML/a (or "-o /a", if
> UML
> is chrooted inside /root/UML).
>
> But it seems that you forgot the -o /root/UML/a part and assumed that
> could be
> given on the first part... even /proc/mounts contains most mount options.
> I've had just re-checked that even when the root is passed with -o, that
> is
> used even for the mount-point. And now I've actually ran the test...
>> df -h on host:
>>
>> Filesystems           Size  Used Avail Use% Mounted on
>> /dev/hda2             7.3G  6.2G  717M  90% /
>> none                  126M     0  126M   0% /dev/shm
>> 192.168.1.1:/var/home/stian
>>                       147G  104G   37G  75% /root/UML/a
>
>> mount on host
>
>> /dev/hda2 on / type xfs (rw,noatime)
>> none on /dev type devfs (rw)
>> none on /proc type proc (rw)
>> noen on /dev/shm type tmpfs (rw)
>> 192.l68.1.1:/var/home/stian on /root/UML/a type nfs
>> (rw,addr=192.168.1.1)
>
>> The problem is the nfs partition you can see, that is mounted inside UML
>> again as hostfs. (This setup is a recovery of a broken disk where I
>> wanted
>> the cow layer when testing recoverytools and dumping out files they
>> found). The UML-kernel itself is 2.6.10-rc3-mm1 with the patch-set from
>> the web-pages dated back 1-2 weeks ago.

Stian


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

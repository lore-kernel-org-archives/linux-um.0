Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AB4sb-0006pc-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 21:09:21 -0700
Received: from bay7-f32.bay7.hotmail.com ([64.4.11.32] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAujL-0006rx-BX
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 10:19:07 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F32HXZkaIZrbKF0002167a@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 18 Oct 2003 17:15:11 +0000
Content-Transfer-Encoding: 8bit
To: hno@marasystems.com, blaisorblade_spam@yahoo.it
Cc: User-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:
>What I do not quite get in this discussion is why one does not want to
>have the selected files available in the chroot in the first place?

Check out Jeff's talk on UML security and chroot:

  http://user-mode-linux.sourceforge.net/slides/ists2002/text17.htm

>To chroot you need to be root. As root you are also allowed to map files
>around using mount --bind.

I can't really argue with that, except hundreds of /etc/mtab entries might 
be annoying :)  (yes, I know you could mount -n to hide them).

BlaisorBlade wrote:
>Alle 16:08, marted� 14 ottobre 2003, Steve Schmidtke ha scritto:
> > yes. The discussion for a previous patch considered a "mm" table to hold 
>a
> > pool of /proc/mm files to handle one fd per process.
> > [....]
>Nooo! Don't make your like hard!

It's making the crackers lives hard that I'm attempting; making mine 
difficult in the process is merely an occupational hazard.

>cd <chroot path>
>mkdir proc
>touch proc/mm #You must create the mount point. In this case it's a file.
>(as root)mount --bind /proc/mm proc/mm
><start Uml binary with "# chroot . linux ...." >

--bind is useful, and I'm trying to avoid it out of principle, not because I 
don't know about it.  In this case --bind would work because /proc/mm is 
writable by everyone, so when the chroot wrapper drops root, the UML can 
still access the file.  That is not the case for all files you may want to 
give a non-root UML access to.

>About the ugliness, it's only a userspace syntax matter. This is the v2 of 
>the
>umlwrap syntax. Instead of this:
>   umlwrap -bind=21,/dev/shm/mconsole1 -dir=/home/uml -- \
>   /bin/linux mem=48M uml_dir=/uml/ umid=um1 filemap=22,/uml/um1/pid \
>   22</dev/shm/pid filemap=21,/uml/um1/mconsole
>
>We can have this:
>   umlwrap -dir=/home/uml -bind=/dev/shm/mconsole1,/uml/um1/mconsole \
>   -map=r,/dev/shm/pid,/uml/um1/pid-- /bin/linux mem=48M uml_dir=/uml/ 
>umid=um1

Yup, that's what I'm leaning towards.

>umlwrap will then setup the needed "filemap" options, at the end of the
>command line.

The order of the command line arguments may be important:  filemap options 
should be parsed before options that reference them (i.e. they should come 
first, not last, on the command line).

>However, does UML(unlike vanilla kernel) supports so long(>512
>char) command lines in the internal kernel part, (in the userspace part 
>it's
>granted)? If not, we can use a patch out there that is already used by
>Knoppix.

Adam Heath is working on a patch for reading config files that will also 
make command line length irrelevant.  I like this approach since the UML 
command line wouldn't have to be mangled to add filemap options to it.

Steve Schmidtke

_________________________________________________________________
Fretting that your Hotmail account may expire because you forgot to sign in 
enough? Get Hotmail Extra Storage today!   
http://join.msn.com/?PAGE=features/es



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

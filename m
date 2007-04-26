Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hh4nQ-0008SQ-Hn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 07:18:08 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hh4nP-0002g0-UO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 07:18:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Apr 2007 16:17:30 +0200
References: <1177579328.5349.10.camel@xaustrobit>
In-Reply-To: <1177579328.5349.10.camel@xaustrobit>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704261617.31010.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml crashes when producing large files
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

On gioved=EC 26 aprile 2007, Herbert Volkmann wrote:
> Hi List,
>
> i ran in the following problem:
Very strange...
> when i produce files (with dd) or copy files to or from the uml machine,
Which filesystems are involved? Can you give a sample command?

> i can see (with top),
Run on the guest (i.e. UML) I guess, right?
> that the used memory and the cached things=20
> increases, while the unused memory will go down.
That is reasonable, but the cache should not make the system stop.
> shortly before memory=20
> will come to zero, the uml stops working completely without any messages
> in the /var/log/* files on uml or host system.
>
> if i do in between a "echo 3 > /proc/sys/vm/drop_caches"
On the guest (i.e. UML) I assume, right?
>
> it cleans caches, frees memory and works fine! but i have to do this all
> 10 seconds when i use dd for producing large files ;-(
>
> these are the components i use:
> - debian etch on host with debian kernel patched with skas3 from debian
32bit system, right?
> - 1024 MB RAM on host
> - RAID5 System with 3ware Controller (5x2G) almost 1 TB
> - on uml i use debian etch, with bridged networking, 512MB RAM for uml
Which UML kernel release? That's the most important thing.
> - 6G root_fs for uml and 256M swap
>
> here is the command with which i start the uml:
> sudo -u uml /usr/bin/linux.uml umid=3Duml mem=3D512M eth0=3Dtuntap,tap1
> ubd0=3D/usr/media/uml-linux/root_fs_2007_04_23
> ubd1=3D/usr/media/uml-linux/swap_fs con=3Dnull root=3D/dev/ubda uml_dir=
=3D/tmp/
>
> I would be really happy if someone could tell me what i can test more to
> find out why this system is instable with i/o operations and caches.

I have only a doubt: if you are filling a shmfs/tmpfs filesystem (which is =

backed by ram), that's an almost normal behaviour, and can happen even on=20
host systems.

> thanx for any reply,
> Herbert

--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


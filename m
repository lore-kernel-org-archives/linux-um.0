Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <425EE656.8040108@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-user] Re: [uml-devel] resizing root_fs
References: <000501c53fde$626198a0$0201a8c0@lualele>
	<200504142303.43628.blaisorblade@yahoo.it>
In-Reply-To: <200504142303.43628.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Date: Thu, 14 Apr 2005 15:53:26 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, itamar <itamar@ispbrasil.com.br>, uml-user <user-mode-linux-user@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
> On Wednesday 13 April 2005 06:07, itamar wrote:
> 
>>dd if=/dev/zero of=root_fs.ext3 bs=1 count=1 seek=40G conv=notrunc
> 
> Right enlarging command, it seems.
> 
>>[root@router conacci]# resize2fs -p root_fs.ext3
>>resize2fs 1.36 (05-Feb-2005)
>>resize2fs: File too large while trying to determine filesystem size
> 
> 
> This old resize2fs has a problem because the file is >= 2G (or something like 
> that), it seems... probably truncating the file to a more normal size and 
> retesting will work, so you possibly hit a resize2fs bug... at least so I 
> guess. It's strange though, but I don't see any other possible explaination.

Because the filesystem size was so small to begin with (256 MB if I
remember correctly), inodes only represent 1K of data.  Resizing the
filesystem then creates more 1K blocks, but you run into the maximum
number of inodes that the filesystem can create.  Try to determine the
maximum size you can resize to, or create the new large filesystem and
move everything from the old to the new.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXuZWaI0dwg4A47wRAnFSAKCdfYAJsopZh/GmLiVvDiL/sTgoDgCeJy9R
KpeFtqFoDf9WkGOdEY1g03Y=
=ELrL
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <510C2858.9040708@oracle.com>
Date: Fri, 01 Feb 2013 14:40:56 -0600
From: Dave Kleikamp <dave.kleikamp@oracle.com>
MIME-Version: 1.0
References: <1359476623-10544-1-git-send-email-dave.kleikamp@oracle.com>
	<1359476623-10544-19-git-send-email-dave.kleikamp@oracle.com>
	<1359705069.32509.67.camel@sauron.fi.intel.com>
In-Reply-To: <1359705069.32509.67.camel@sauron.fi.intel.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH V6 18/30] fs: add read_iter and write_iter
 to several file systems
To: dedekind1@gmail.com
Cc: jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, Bob Copeland <me@bobcopeland.com>, linux-mtd@lists.infradead.org, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, linux-nilfs@vger.kernel.org, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>, v9fs-developer@lists.sourceforge.net, linux-ext4@vger.kernel.org, Prasad Joshi <prasadjoshi.linux@gmail.com>, "Maxim V. Patlasov" <mpatlasov@parallels.com>, Evgeniy Dushistov <dushistov@mail.ru>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, reiserfs-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Joern Engel <joern@logfs.org>, "Tigran A. Aivazian" <tigran@aivazian.fsnet.co.uk>, linux-kernel@vger.kernel.org, logfs@logfs.org, Benny Halevy <bhalevy@tonian.com>, linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Morton <akpm@linux-foundation.org>, Zach Brown <zab@zabbo.net>, David Woodhouse <dwmw2@infradead.org>, linux-karma-devel@lists.sourceforge.net, osd-dev@open-osd.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/01/2013 01:51 AM, Artem Bityutskiy wrote:
> On Tue, 2013-01-29 at 10:23 -0600, Dave Kleikamp wrote:
>> -       .aio_read = generic_file_aio_read, -       .aio_write =
>> generic_file_aio_write, +       .read_iter =
>> generic_file_read_iter, +       .write_iter =
>> generic_file_write_iter,
> 
> The new names a lot less self-documenting than the old ones - I
> read them as "read iteration", because "iter" is often used for
> "iteration", and this gives me no clue that they are related to
> AIO...

Zach Brown originally came up with these (or at least he's the one who
did the majority of the initial work with this patchset) and I can't
speak for him, but I'm not sure if I could come up with a better name.
(Maybe aio_read_iter/aio_write_iter?) These operations are
differentiated from aio_read/write because they take the iov_iter
argument rather than an iovec, so "iter" does seem appropriate.

> I apologize if this was already discussed, but why did you choose 
> "iter"?

It hasn't been discussed, but nobody has said anything about the names
until now. I hesitate to change the proposed names now unless there's
some kind of consensus to do so.

If others chime in and want me to change these to aio_read_iter and
aio_write_iter or something else, I'll consider it.

Thanks,
Shaggy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRDChYAAoJEDaohF61QIxkRAkP/0HRsRwVPU/mKJx3BSlw44st
sWrbKNPhVaMpHQtJP+w7CisgwC/PzP0mi6wV5FyQ0ZmUkMEkWJ1Eog8QExCNKnih
VLBsWTBYLmVWQhRzuO6K91H2/n3rkTN2f5s0CT6bgDvBnme295UrRCpb5Yb5r/Xr
eW16lX+4W8G5tEfDCKpvtzr0zSpxzIt5S8CsQEAaeVuskfZ+s/UKDjLUtQi4H2jP
MVJNBrXzJ4zlDPIRXrh3PPfcG1ii2ai9+3UQChWw5XGhln4ttmh5GT9PHEyznizM
iSn9DYUxa3OPJCwx759eZAUzK/s4es/S9vwg1psJqBU6nIIcl9UQRQhbNdywoqQ5
N6JmSXF8oToTH4HTBc4K32zJ1P9qi2oQeVu1Jzdpoz6v8XgJGUnrkoceVgQTjJRF
H1kramDQB6zwzfCmYlZniAhP1LcbZ6ON/GgpdtOwl2q++gHO9+e5LGIDJNMhd3Kc
MJ3jJXDvy5Flsi9qY4h7Mh7hdpQAmF4ZpMXRlHtHFPlK3RvjDoW5UwBcjGiulVYt
9tx9hhLHztBe1Fs9b1GbUDTs2fZHH4g75+pSUfQgyPhk6DNz21KBA1eClC0JZpYK
UYFpnUf4p9aYK3WwB+nrchASmiWYisxL7xTQKCn2NVCG48XpDjtJj8dQGvcgBG9n
YS/fnE0ljbrWW4W+yZG5
=VJcR
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Dec 2013 15:02:14 +0100
From: Jan Kara <jack@suse.cz>
Message-ID: <20131203140214.GB31128@quack.suse.cz>
References: <529217CD.1000204@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <529217CD.1000204@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: why does index in truncate_inode_pages_range() grows so much ?
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun 24-11-13 16:14:21, Toralf F=F6rster wrote:
> At a 32 bit guest UML with current kernel git tree I putted a printk
> into that function :
>=20
> void truncate_inode_pages_range(struct address_space *mapping,
>                                 loff_t lstart, loff_t lend)
> {
> ...
>=20
>=20
>                 cond_resched();
>                 index++;
> 		printk ("            <------------
>=20
>=20
>=20
>=20
> and got (while fuzzying the UML guest with trinity) this output in th=
e
> UML guest:
>=20
>=20
> Nov 24 12:06:53 trinity kernel: index:42 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:43 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:5 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1035468800 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:16 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:4 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:2 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:4184867847 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:3 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1727 end:4294967295
> Nov 24 12:06:53 trinity kernel: index:1 end:4294967295
>=20
>=20
> I'm wondering if index is expected to become sometimes so big.
  No, I wouldn't expect such huge indices. OTOH with fuzzing there coul=
d be
some valid explanations. Could you move the printk before
pagevec_release(), print also 'start' variable and in case 'index' is
suspiciously large, print also 'i' and some info about the page pvec[i]
page (page->index, page->flags, page->mapping->host->i_sb->s_id,
page->mapping->host->i_ino)?

								Honza
--=20
Jan Kara <jack@suse.cz>
SUSE Labs, CR
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


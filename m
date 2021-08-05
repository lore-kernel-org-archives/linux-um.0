Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBeCH-009pMk-C5
 for linux-um@lists.infradead.org; Thu, 05 Aug 2021 14:18:11 +0000
Date: Thu, 5 Aug 2021 15:17:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 08/15] virtio_blk: use bvec_virt
Message-ID: <YQvzD4FlF7+AgrSw@stefanha-x1.localdomain>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-9-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-9-hch@lst.de>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2326107934553740541=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-um@lists.infradead.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org


--===============2326107934553740541==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZDhkEMoj7rmqL+Fh"
Content-Disposition: inline


--ZDhkEMoj7rmqL+Fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 11:56:27AM +0200, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZDhkEMoj7rmqL+Fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEL8w8ACgkQnKSrs4Gr
c8jPdgf+PcMouWs94g0uS6wpaN9fVvtvzsyRrLa0a4jPqggbtSulcjUYQzYZ9BGX
1xnrp3ABDt4KhYhX+iAsAxc4LmWEAYUruE6WxqsxaPKE19XcFuwM/tpwcv5U8/x+
2GvsXderla2RbbwTzdCFUf1m538Dw+eqH8+6Dt0Q6QjCC4EAX3ubWU+pX0K5rLNX
d7M7JCyOzOdU/VJYYVQDs1Vkpu/2AFtQT+hnq7veWzgQD+iFkLNZUEBVFm4jRbkC
5cfC+IUVtDkCjhD2offyhX+djtvDy5IZAnHEMv/ulIMmCzc0o1VgEy/5zNiKnjgg
5CdxbrfAKcA734P4gNIy/UD+hGlM6g==
=Cztj
-----END PGP SIGNATURE-----

--ZDhkEMoj7rmqL+Fh--



--===============2326107934553740541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2326107934553740541==--




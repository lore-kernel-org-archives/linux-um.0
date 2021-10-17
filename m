Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Sun, 17 Oct 2021 16:12:19 +0200
From: Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <YWwvQ+YMAKzX1aO3@ninjato>
References: <20211013105226.20225-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3118491184163954216=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@codeaurora.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Eric Van Hensbergen <ericvh@gmail.com>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Stefano Garzarella <sgarzare@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org, alsa-devel@alsa-project.org


--===============3118491184163954216==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byZ/nyBYz0KyHzOz"
Content-Disposition: inline


--byZ/nyBYz0KyHzOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 06:55:31AM -0400, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C changes


--byZ/nyBYz0KyHzOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFsLz8ACgkQFA3kzBSg
KbbhcRAAqrAP/5XyaQEyoVcqsJ6xfTgBJXC8/fUFVary0yMagmjEQLKzCbVBRQiF
UyKdQuoAJkemPBp13oZuYHgojk26k9r+hRKLoXigmy0tMboLZisXMh7/pcFDyz2e
1C+0lbx3IQ5Q9LV590CAlOS1i7wPOXFDW0LkIu1mb8TX2Z2NU4G7Tz9TQlGBXO39
MhIC6ggPDf141nztlFknKIlcLzpBXatCQrhN7cdcr3LxTjoKa20bHHVIGokKmFma
sJK0vVc5vuqlye+Ea8AZ1jzol4xFQRcSHoNCC5MfHUfxVaJ3mvYQ6jXl9cAfYkLN
0V5IehblsGFyBZ/Kpw/9SnPGTBV2Chs/o4JURyiKp3wVIpkAMagVz9OI4cOC+TTt
8007Fqv9jQtFpu+w9FC3//i0C+JiUH12eYjCt8Me4FZC4EHIosqfm8i7yRB+MZIv
WtaR04OJSlPS/DVFNb1AhUrvITU7uOw2fvVRyyC33iPXIJpvDoyoS9voJTGWYxRn
u7CYO2yy9EfLoB6bPLn4wbfk1TUlbBpSuuycqOpSfjJ0CSEK0d/t4fKkwsDZ+gxb
bS6NiNuzBiaxzsm8EUVR1q+gqY46ywMDIOYmbBykiXipERJofhxjro8Czauj9+b6
FgdQ6J1aFiV8/k36NqD1M5WdM3VecyPECGa7Ba2Nce+uc/k8jCw=
=Y+5l
-----END PGP SIGNATURE-----

--byZ/nyBYz0KyHzOz--


--===============3118491184163954216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============3118491184163954216==--



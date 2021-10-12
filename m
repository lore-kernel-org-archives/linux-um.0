Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maBnZ-00BjGW-Gt
 for linux-um@lists.infradead.org; Tue, 12 Oct 2021 07:02:07 +0000
Message-ID: <55fceaaa0e44585e2b8aeb4ce57d9a5248a879e7.camel@perches.com>
Subject: Re: [PATCH v2] Fix application of sizeof to pointer
From: Joe Perches <joe@perches.com>
Date: Tue, 12 Oct 2021 00:01:58 -0700
In-Reply-To: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
References: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: davidcomponentone@gmail.com, jdike@addtoit.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>

On Tue, 2021-10-12 at 14:50 +0800, davidcomponentone@gmail.com wrote:
> From: David Yang <davidcomponentone@gmail.com>
> =

> The coccinelle check report:
> "./arch/um/drivers/virt-pci.c:192:20-26:
> ERROR: application of sizeof to pointer"
> Using the "sizeof(buf->data)" to fix it.

Try compiling this with W=3D1 or just maybe even just compiling your change.
You've now got an unused declaration of u8 *data;
 =

> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
[]
> @@ -187,9 +187,8 @@ static unsigned long um_pci_cfgspace_read(void *priv,=
 unsigned int offset,
> =A0		return ~0ULL;
> =

> =A0	buf =3D get_cpu_var(um_pci_msg_bufs);
> -	data =3D buf->data;
> =

> -	memset(data, 0xff, sizeof(data));
> +	memset(buf->data, 0xff, sizeof(buf->data));
> =A0	switch (size) {
> =A0	case 1:
> @@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *pri=
v, unsigned int offset,
> =A0		goto out;
> =A0	}
> =

> -	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
> +	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
> =A0		goto out;
> =

> =A0	switch (size) {
> =A0	case 1:
> -		ret =3D data[0];
> +		ret =3D buf->data[0];
> =A0		break;
> =A0	case 2:
> -		ret =3D le16_to_cpup((void *)data);
> +		ret =3D le16_to_cpup((void *)buf->data);
> =A0		break;
> =A0	case 4:
> -		ret =3D le32_to_cpup((void *)data);
> +		ret =3D le32_to_cpup((void *)buf->data);
> =A0		break;
> =A0#ifdef CONFIG_64BIT
> =A0	case 8:
> -		ret =3D le64_to_cpup((void *)data);
> +		ret =3D le64_to_cpup((void *)buf->data);
> =A0		break;
> =A0#endif
> =A0	default:



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


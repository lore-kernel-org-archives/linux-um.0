Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ma8mH-00BNBq-A1
 for linux-um@lists.infradead.org; Tue, 12 Oct 2021 03:48:34 +0000
Message-ID: <bcf19290a2ed959fdf8d80a3668a19e79c87ca7f.camel@perches.com>
Subject: Re: [PATCH virt-pci] Fix application of sizeof to pointer
From: Joe Perches <joe@perches.com>
Date: Mon, 11 Oct 2021 20:48:27 -0700
In-Reply-To: <20211012032333.184581-1-davidcomponentone@gmail.com>
References: <20211012032333.184581-1-davidcomponentone@gmail.com>
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

On Tue, 2021-10-12 at 11:23 +0800, davidcomponentone@gmail.com wrote:
> From: David Yang <davidcomponentone@gmail.com>
> =

> The coccinelle check report:
> "./arch/um/drivers/virt-pci.c:192:20-26:
> ERROR: application of sizeof to pointer"
> Using the "sizeof(buf->data)" to fix it.
[]
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
[]
> @@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv,=
 unsigned int offset,
> =A0	buf =3D get_cpu_var(um_pci_msg_bufs);
> =A0	data =3D buf->data;
> =

> -	memset(data, 0xff, sizeof(data));
> +	memset(data, 0xff, sizeof(buf->data));

Perhaps change this to:

	memset(buf->data, 0xff, sizeof(buf->data));
	data =3D buf->data;

but honestly, the indirection to data doesn't make the code
much more readable so maybe just remove data altogether.
---
 arch/um/drivers/virt-pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c080666330234..75e05ead97b9a 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -180,7 +180,6 @@ static unsigned long um_pci_cfgspace_read(void *priv, u=
nsigned int offset,
 	};
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
-	u8 *data;
 	unsigned long ret =3D ~0ULL;
 =

 	if (!dev)
@@ -189,7 +188,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, u=
nsigned int offset,
 	buf =3D get_cpu_var(um_pci_msg_bufs);
 	data =3D buf->data;
 =

-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 =

 	switch (size) {
 	case 1:
@@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv,=
 unsigned int offset,
 		goto out;
 	}
 =

-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
 		goto out;
 =

 	switch (size) {
 	case 1:
-		ret =3D data[0];
+		ret =3D buf->data[0];
 		break;
 	case 2:
-		ret =3D le16_to_cpup((void *)data);
+		ret =3D le16_to_cpup((void *)buf->data);
 		break;
 	case 4:
-		ret =3D le32_to_cpup((void *)data);
+		ret =3D le32_to_cpup((void *)buf->data);
 		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		ret =3D le64_to_cpup((void *)data);
+		ret =3D le64_to_cpup((void *)buf->data);
 		break;
 #endif
 	default:



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


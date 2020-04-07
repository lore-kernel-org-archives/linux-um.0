Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] um: add a generic "fd" vector transport
Date: Tue,  7 Apr 2020 22:28:53 +0200
Message-Id: <20200407202853.1791218-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, joerd.simons@collabora.co.uk, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, alex.dewar@gmx.co.uk, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
List-ID: <linux-um.lists.infradead.org>

Learn to take a pre-opened file-descriptor for vector IO.

Instead of teaching the driver to open a FD in multiple ways, it can
rely on management layer to do it on its behalf. For example, this
allows inheriting a preconfigured device fd or a simple socketpair()
setup, without further arguments, privileges or system access by UML.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 arch/um/drivers/vector_user.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.=
c
index 29fae0456ade..45c1550dbb37 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -29,6 +29,7 @@
 #include <netdb.h>
 #include <stdlib.h>
 #include <os.h>
+#include <limits.h>
 #include <um_malloc.h>
 #include "vector_user.h"
=20
@@ -42,6 +43,9 @@
 #define TRANS_RAW "raw"
 #define TRANS_RAW_LEN strlen(TRANS_RAW)
=20
+#define TRANS_FD "fd"
+#define TRANS_FD_LEN strlen(TRANS_FD)
+
 #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
 #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
 #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=3D%i"
@@ -347,6 +351,59 @@ static struct vector_fds *user_init_unix_fds(struct =
arglist *ifspec, int id)
 	return NULL;
 }
=20
+static int strtofd(const char *nptr)
+{
+	long fd;
+	char *endptr;
+
+	if (nptr =3D=3D NULL)
+		return -1;
+
+	errno =3D 0;
+	fd =3D strtol(nptr, &endptr, 10);
+	if (nptr =3D=3D endptr ||
+		errno !=3D 0 ||
+		*endptr !=3D '\0' ||
+		fd < 0 ||
+		fd > INT_MAX) {
+		return -1;
+	}
+	return fd;
+}
+
+static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
+{
+	int fd =3D -1;
+	char *fdarg =3D NULL;
+	struct vector_fds *result =3D NULL;
+
+	fdarg =3D uml_vector_fetch_arg(ifspec, "fd");
+	fd =3D strtofd(fdarg);
+	if (fd =3D=3D -1) {
+		printk(UM_KERN_ERR "fd open: bad or missing fd argument");
+		goto fd_cleanup;
+	}
+
+	result =3D uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result =3D=3D NULL) {
+		printk(UM_KERN_ERR "fd open: allocation failed");
+		goto fd_cleanup;
+	}
+
+	result->rx_fd =3D fd;
+	result->tx_fd =3D fd;
+	result->remote_addr_size =3D 0;
+	result->remote_addr =3D NULL;
+	return result;
+
+fd_cleanup:
+	if (fd >=3D 0)
+		os_close_file(fd);
+	if (result !=3D NULL)
+		kfree(result);
+	return NULL;
+}
+
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
 	int rxfd =3D -1, txfd =3D -1;
@@ -578,6 +635,8 @@ struct vector_fds *uml_vector_user_open(
 		return user_init_socket_fds(parsed, ID_L2TPV3);
 	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) =3D=3D 0)
 		return user_init_unix_fds(parsed, ID_BESS);
+	if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) =3D=3D 0)
+		return user_init_fd_fds(parsed);
 	return NULL;
 }
=20
--=20
2.26.0.106.g9fadedd637



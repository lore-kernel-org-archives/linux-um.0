Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan <gnomes@lxorguk.ukuu.org.uk>
Date: Tue, 20 Jan 2015 12:11:12 +0000
Message-ID: <20150120121100.28406.95201.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH RESEND] um,ethertap: use strncpy
To: greg@kroah.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I can't prove the case pointed out in
https://bugzilla.kernel.org/show_bug.cgi?id=82341
is correct so let us play safe.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index b39b669..6d49182 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	sprintf(data_fd_buf, "%d", data_remote);
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 	if (gate != NULL) {
-		strcpy(gate_buf, gate);
+		strncpy(gate_buf, gate, 15);
 		args = setup_args;
 	}
 	else args = nosetup_args;


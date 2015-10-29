Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Saurabh Sengar <saurabh.truth@gmail.com>
Date: Thu, 29 Oct 2015 12:53:12 +0530
Message-Id: <1446103392-28728-1-git-send-email-saurabh.truth@gmail.com>
In-Reply-To: <saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] git: um: replace GFP_KERNEL with GFP_ATOMIC while spinlock is held
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

replace GFP_KERNEL with GFP_ATOMIC while spinlock is held,
as code while holding a spinlock should be atomic.
GFP_KERNEL may sleep and can cause deadlock,
where as GFP_ATOMIC may fail but certainly avoids deadlock

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 arch/um/drivers/net_kern.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index f70dd54..7d4b709 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -388,16 +388,22 @@ static const struct net_device_ops uml_netdev_ops = {
 static int driver_registered;
 
 static void eth_configure(int n, void *init, char *mac,
-			  struct transport *transport)
+			  struct transport *transport, bool atomic)
 {
 	struct uml_net *device;
 	struct net_device *dev;
 	struct uml_net_private *lp;
 	int err, size;
+	int gfp_mask;
 
 	size = transport->private_size + sizeof(struct uml_net_private);
 
-	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (atomic)
+		gfp_mask = GFP_ATOMIC;
+	else
+		gfp_mask = GFP_KERNEL;
+
+	device = kzalloc(sizeof(*device), gfp_mask);
 	if (device == NULL) {
 		printk(KERN_ERR "eth_configure failed to allocate struct "
 		       "uml_net\n");
@@ -568,9 +574,10 @@ static LIST_HEAD(transports);
 static LIST_HEAD(eth_cmd_line);
 
 static int check_transport(struct transport *transport, char *eth, int n,
-			   void **init_out, char **mac_out)
+			   void **init_out, char **mac_out, bool atomic)
 {
 	int len;
+	int gfp_mask;
 
 	len = strlen(transport->name);
 	if (strncmp(eth, transport->name, len))
@@ -582,7 +589,12 @@ static int check_transport(struct transport *transport, char *eth, int n,
 	else if (*eth != '\0')
 		return 0;
 
-	*init_out = kmalloc(transport->setup_size, GFP_KERNEL);
+	if (atomic)
+		gfp_mask = GFP_ATOMIC;
+	else
+		gfp_mask = GFP_KERNEL;
+
+	*init_out = kmalloc(transport->setup_size, gfp_mask);
 	if (*init_out == NULL)
 		return 1;
 
@@ -600,6 +612,7 @@ void register_transport(struct transport *new)
 	void *init;
 	char *mac = NULL;
 	int match;
+	bool atomic = false;
 
 	spin_lock(&transports_lock);
 	BUG_ON(!list_empty(&new->list));
@@ -609,11 +622,11 @@ void register_transport(struct transport *new)
 	list_for_each_safe(ele, next, &eth_cmd_line) {
 		eth = list_entry(ele, struct eth_init, list);
 		match = check_transport(new, eth->init, eth->index, &init,
-					&mac);
+					&mac, atomic);
 		if (!match)
 			continue;
 		else if (init != NULL) {
-			eth_configure(eth->index, init, mac, new);
+			eth_configure(eth->index, init, mac, new, atomic);
 			kfree(init);
 		}
 		list_del(&eth->list);
@@ -627,14 +640,16 @@ static int eth_setup_common(char *str, int index)
 	void *init;
 	char *mac = NULL;
 	int found = 0;
+	bool atomic = false;
 
 	spin_lock(&transports_lock);
+	atomic = true;
 	list_for_each(ele, &transports) {
 		transport = list_entry(ele, struct transport, list);
-	        if (!check_transport(transport, str, index, &init, &mac))
+	        if (!check_transport(transport, str, index, &init, &mac, atomic))
 			continue;
 		if (init != NULL) {
-			eth_configure(index, init, mac, transport);
+			eth_configure(index, init, mac, transport, atomic);
 			kfree(init);
 		}
 		found = 1;
-- 
1.9.1


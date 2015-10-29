Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Saurabh Sengar <saurabh.truth@gmail.com>
Date: Thu, 29 Oct 2015 14:46:43 +0530
Message-Id: <1446110203-21968-1-git-send-email-saurabh.truth@gmail.com>
In-Reply-To: <saurabh.truth@gmail.com>
References: <saurabh.truth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v3] um: net: replace GFP_KERNEL with GFP_ATOMIC when spinlock is held
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

replace GFP_KERNEL with GFP_ATOMIC while spinlock is held,
as code while holding a spinlock should be atomic.
GFP_KERNEL may sleep and can cause deadlock,
where as GFP_ATOMIC may fail but certainly avoids deadlock

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
v3: removed the atomic variable, as per Richard comment

 arch/um/drivers/net_kern.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index f70dd54..d898f6c 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -388,7 +388,7 @@ static const struct net_device_ops uml_netdev_ops = {
 static int driver_registered;
 
 static void eth_configure(int n, void *init, char *mac,
-			  struct transport *transport)
+			  struct transport *transport, int gfp_mask)
 {
 	struct uml_net *device;
 	struct net_device *dev;
@@ -397,7 +397,7 @@ static void eth_configure(int n, void *init, char *mac,
 
 	size = transport->private_size + sizeof(struct uml_net_private);
 
-	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), gfp_mask);
 	if (device == NULL) {
 		printk(KERN_ERR "eth_configure failed to allocate struct "
 		       "uml_net\n");
@@ -568,7 +568,7 @@ static LIST_HEAD(transports);
 static LIST_HEAD(eth_cmd_line);
 
 static int check_transport(struct transport *transport, char *eth, int n,
-			   void **init_out, char **mac_out)
+			   void **init_out, char **mac_out, int gfp_mask)
 {
 	int len;
 
@@ -582,7 +582,7 @@ static int check_transport(struct transport *transport, char *eth, int n,
 	else if (*eth != '\0')
 		return 0;
 
-	*init_out = kmalloc(transport->setup_size, GFP_KERNEL);
+	*init_out = kmalloc(transport->setup_size, gfp_mask);
 	if (*init_out == NULL)
 		return 1;
 
@@ -600,20 +600,22 @@ void register_transport(struct transport *new)
 	void *init;
 	char *mac = NULL;
 	int match;
+	int gfp_mask;
 
 	spin_lock(&transports_lock);
 	BUG_ON(!list_empty(&new->list));
 	list_add(&new->list, &transports);
 	spin_unlock(&transports_lock);
 
+	gfp_mask = GFP_KERNEL;
 	list_for_each_safe(ele, next, &eth_cmd_line) {
 		eth = list_entry(ele, struct eth_init, list);
 		match = check_transport(new, eth->init, eth->index, &init,
-					&mac);
+					&mac, gfp_mask);
 		if (!match)
 			continue;
 		else if (init != NULL) {
-			eth_configure(eth->index, init, mac, new);
+			eth_configure(eth->index, init, mac, new, gfp_mask);
 			kfree(init);
 		}
 		list_del(&eth->list);
@@ -627,14 +629,17 @@ static int eth_setup_common(char *str, int index)
 	void *init;
 	char *mac = NULL;
 	int found = 0;
+	int gfp_mask;
 
 	spin_lock(&transports_lock);
+	gfp_mask = GFP_ATOMIC;
 	list_for_each(ele, &transports) {
 		transport = list_entry(ele, struct transport, list);
-	        if (!check_transport(transport, str, index, &init, &mac))
+		if (!check_transport(transport, str, index, &init,
+							&mac, gfp_mask))
 			continue;
 		if (init != NULL) {
-			eth_configure(index, init, mac, transport);
+			eth_configure(index, init, mac, transport, gfp_mask);
 			kfree(init);
 		}
 		found = 1;
-- 
1.9.1


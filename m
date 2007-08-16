Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILb1b-0004ca-Jf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 01:48:15 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILb1X-0006W2-Ni
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 01:48:15 -0700
Received: by ug-out-1314.google.com with SMTP id m2so264256uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Aug 2007 01:48:10 -0700 (PDT)
Date: Thu, 16 Aug 2007 10:47:42 +0200
From: Luca Bigliardi <shammash@artha.org>
Message-ID: <20070816084741.GS23105@pintsize>
References: <20070725143227.GO5115@pintsize>
	<20070725160700.GA7607@c2.user-mode-linux.org>
	<200708121254.10137.blaisorblade@yahoo.it>
	<20070812121019.GL23105@pintsize>
	<20070815152053.GB6889@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20070815152053.GB6889@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [RFC PATCH] vde network backend
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15, 2007 at 11:20 AM, Jeff Dike wrote:

> What did you change?  BB was right to comment on my changelog, but I
> don't see any examples of if( blah ) { anywhere in the vde code.

I've changed "if(blah)" into "if (blah)".

> Since the main patch is in -mm, if you have changes, send incremental
> patches, not updated full patches.

I'm sorry. I'm attaching the diff between the -mm patch and the newer one.


luca

-- 
Beware of programmers who carry screwdrivers.
                        -- Leonard Brandwein

http://shammash.homelinux.org/ - http://www.artha.org/ - http://www.yue.it/

--uZ3hkaAS1mZxFaxD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="uml_vdetransport-02_01.patch"

--- uml_vdetransport-02.patch	2007-07-26 18:49:55.000000000 +0200
+++ uml_vdetransport-03.patch	2007-08-12 14:02:15.000000000 +0200
@@ -142,9 +142,9 @@
 +{
 +	struct vde_data *pri = (struct vde_data *) &lp->user;
 +
-+	if(pri->conn != NULL) {
++	if (pri->conn != NULL) {
 +		*skb = ether_adjust_skb(*skb, ETH_HEADER_OTHER);
-+		if(*skb == NULL)
++		if (*skb == NULL)
 +			return -ENOMEM;
 +
 +		return vde_user_read(pri->conn, skb_mac_header(*skb),
@@ -159,7 +159,7 @@
 +{
 +	struct vde_data *pri = (struct vde_data *) &lp->user;
 +
-+	if(pri->conn != NULL)
++	if (pri->conn != NULL)
 +		return vde_user_write((void *)pri->conn, (*skb)->data,
 +					(*skb)->len);
 +
@@ -189,22 +189,22 @@
 +	remain = split_if_spec(str, &init->vde_switch, mac_out, &port_str,
 +				&init->group, &mode_str, &init->descr, NULL);
 +
-+	if(remain != NULL)
++	if (remain != NULL)
 +		printk(KERN_WARNING "vde_setup - Ignoring extra data :"
 +					"'%s'\n", remain);
 +
-+	if(port_str != NULL) {
++	if (port_str != NULL) {
 +		init->port = simple_strtoul(port_str, &last, 10);
-+		if((*last != '\0') || (last == port_str)) {
++		if ((*last != '\0') || (last == port_str)) {
 +			printk(KERN_ERR "vde_setup - Bad port : '%s'\n",
 +						port_str);
 +			return 0;
 +		}
 +	}
 +	
-+	if(mode_str != NULL) {
++	if (mode_str != NULL) {
 +		init->mode = simple_strtoul(mode_str, &last, 8);
-+		if((*last != '\0') || (last == mode_str)) {
++		if ((*last != '\0') || (last == mode_str)) {
 +			printk(KERN_ERR "vde_setup - Bad mode : '%s'\n",
 +						mode_str);
 +			return 0;
@@ -265,7 +265,7 @@
 +
 +	conn = vde_open(pri->vde_switch, pri->descr, pri->args);
 +	
-+	if(conn == NULL) {
++	if (conn == NULL) {
 +		err = -errno;
 +		printk(UM_KERN_ERR "vde_user_init: vde_open failed, "
 +					"errno = %d\n", errno);
@@ -283,7 +283,7 @@
 +{
 +	struct vde_data *pri = data;
 +
-+	if(pri->conn != NULL)
++	if (pri->conn != NULL)
 +		return vde_datafd(pri->conn);
 +	
 +	printk(UM_KERN_WARNING "vde_open - we have no VDECONN to open");
@@ -294,7 +294,7 @@
 +{
 +	struct vde_data *pri = data;
 +
-+	if(pri->conn != NULL) {
++	if (pri->conn != NULL) {
 +		printk(UM_KERN_INFO "vde backend - closing connection\n");
 +		vde_close(pri->conn);
 +		pri->conn = NULL;
@@ -327,7 +327,7 @@
 +	struct vde_open_args *args;
 +
 +	vpri->args = kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
-+	if(vpri->args == NULL) {
++	if (vpri->args == NULL) {
 +		printk(UM_KERN_ERR "\nvde_init_libstuff - vde_open_args"
 +					"allocation failed");
 +		return;
@@ -348,16 +348,16 @@
 +	VDECONN *vconn = (VDECONN *) conn;
 +	int rv;
 +
-+	if(vconn == NULL)
++	if (vconn == NULL)
 +		return 0;
 +
 +	rv = vde_recv(vconn, buf, len, 0);
-+	if(rv < 0) {
-+		if(errno == EAGAIN)
++	if (rv < 0) {
++		if (errno == EAGAIN)
 +			return 0;
 +		return -errno;
 +	}
-+	else if(rv == 0)
++	else if (rv == 0)
 +		return -ENOTCONN;
 +
 +	return rv;
@@ -367,7 +367,7 @@
 +{
 +	VDECONN *vconn = (VDECONN *) conn;
 +
-+	if(vconn == NULL)
++	if (vconn == NULL)
 +		return 0;
 +
 +	return vde_send(vconn, buf, len, 0);

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--uZ3hkaAS1mZxFaxD--


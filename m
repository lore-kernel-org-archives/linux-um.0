Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A41Cr-00055O-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 09:49:05 -0700
Received: from [213.158.72.3] (helo=community.interfree.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A41Cq-0003YB-Mx
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 09:49:04 -0700
From: marco ancillotti <mancillotti@interfree.it>
Content-Type: multipart/mixed; boundary="=-EIDCCZNCSbx6v5vL1g1+"
Message-Id: <1064854051.21559.5.camel@mancillotti.retesintesi.net>
Mime-Version: 1.0
Subject: [uml-devel] mconsole proc interface patch
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: 29 Sep 2003 18:47:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--=-EIDCCZNCSbx6v5vL1g1+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

in last version of uml patch there's a bug that make uml crash when from
uml_mconsole someone try to use:

proc ../SOMETHINK

there's a patch to resolv prolem.

bye,
marco.

----------------------------------------------------

--- mconsole_kern.c.old	2003-09-29 18:27:36.000000000 +0200
+++ mconsole_kern.c	2003-09-29 18:37:38.000000000 +0200
@@ -158,6 +158,11 @@
 	nd.flags = O_RDONLY + 1;
 	nd.last_type = LAST_ROOT;
 
+	if ( strstr ( ptr , "../" ) == ptr ) {
+		mconsole_reply(req , "Not a valid file" , 1 ,0);
+		goto out_kill;
+	}
+
 	err = link_path_walk(ptr, &nd);
 	if(err){
 		mconsole_reply(req, "Failed to look up file", 1, 0);


----------------------------------------------------


-- 
----------------------------------------------------

Marco Ancillotti 
uniX / Linux Tecnical specialist

- IBM Aix Certified Advanced Tecnical Specialist
- IBM Enterprise storage specialist
- Red Hat Certified Engineer

    Lpar manager first developer and mantainer.
( http://savannah.nongnu.org/projects/lparmanager )

S.in.te.si. srl
via cecchi 28
50053 Empoli (FI)
tel: 0571/72400
fax: 0571/72064

mancillotti@interfree.it
cell: 347/3460086

----------------------------------------------------

--=-EIDCCZNCSbx6v5vL1g1+
Content-Disposition: attachment; filename=nero.patch
Content-Type: text/x-diff; name=nero.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- mconsole_kern.c.old	2003-09-29 18:27:36.000000000 +0200
+++ mconsole_kern.c	2003-09-29 18:37:38.000000000 +0200
@@ -158,6 +158,11 @@
 	nd.flags = O_RDONLY + 1;
 	nd.last_type = LAST_ROOT;
 
+	if ( strstr ( ptr , "../" ) == ptr ) {
+		mconsole_reply(req , "Not a valid file" , 1 ,0);
+		goto out_kill;
+	}
+
 	err = link_path_walk(ptr, &nd);
 	if(err){
 		mconsole_reply(req, "Failed to look up file", 1, 0);

--=-EIDCCZNCSbx6v5vL1g1+--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

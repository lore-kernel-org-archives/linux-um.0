Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVztz-00070F-Ab for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:37:31 -0700
Received: from firewall.seawaynetworks.com ([216.209.86.50]
	helo=apollo.seawaynetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzty-0005mS-4x for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:37:30 -0700
Received: from camelot-054 (camelot-054 [10.10.1.54])
	by apollo.seawaynetworks.com (8.12.8/8.12.8) with ESMTP id
	i53LbLcP002837 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jun 2004 17:37:21 -0400 (EDT)
Message-ID: <27846.1086298625@camelot-054>
From: Michael Richardson <Michael.Richardson@seawaynetworks.com>
Subject: [uml-devel] switch->netjig patch 5
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 03 Jun 2004 17:37:05 -0400
To: user-mode-linux-devel@lists.sourceforge.net


Jeff, this patch ( also http://www.sandelman.ca/tmp/jig5.patch )
just adds GPL headers and CVS log history to some of the files that were
created.

Binary files uml_tools.jig4/uml_router/hash.o and uml_tools.jig5/uml_router/hash.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig4/uml_router/nethub.c uml_tools.jig5/uml_router/nethub.c
--- uml_tools.jig4/uml_router/nethub.c	Thu Jun  3 17:09:34 2004
+++ uml_tools.jig5/uml_router/nethub.c	Thu Jun  3 14:46:45 2004
@@ -1,3 +1,24 @@
+/*
+ * @(#) jig to exercise a UML/FreeSWAN kernel with two interfaces
+ *
+ * Copyright (C) 2001 Michael Richardson  <mcr@freeswan.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * RCSID $Id: nethub.c,v 1.10 2002/08/30 01:37:35 mcr Exp $
+ *
+ * @(#) based upon uml_router from User-Mode-Linux tools package by Jeff Dike.
+ *
+ */
+
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/time.h>
diff -x CVS -x '*~' -u -N -r uml_tools.jig4/uml_router/nethub.h uml_tools.jig5/uml_router/nethub.h
--- uml_tools.jig4/uml_router/nethub.h	Thu Jun  3 17:09:34 2004
+++ uml_tools.jig5/uml_router/nethub.h	Thu Jun  3 14:46:16 2004
@@ -195,6 +195,34 @@
 
 /*
  * $Log: nethub.h,v $
+ * Revision 1.7  2003/04/02 20:25:53  mcr
+ * 	quiet down uml_netjig unless -v or $NETJIGVERBOSE is set.
+ *
+ * Revision 1.6  2003/04/02 02:15:59  mcr
+ * 	added option to set packet replay rate.
+ *
+ * Revision 1.5  2002/11/07 22:18:09  mcr
+ * 	use proper #define for ethernet length.
+ *
+ * Revision 1.4  2002/08/30 01:37:35  mcr
+ * 	double buffered the poll(2) structures so that changes during
+ * 	use would not affect the system.
+ * 	changed fd_array to be indirect references so that the poll(2)
+ * 	loop could more easily double buffer the structures.
+ *
+ * Revision 1.3  2002/07/21 16:40:34  mcr
+ * 	clean pid file upon exit, so that directories can be removed
+ * 	properly. Free up memory that was allocated for the hub.
+ * 	switch to using mkstemp instead of tmpname for directory
+ * 	creation - append .d to the generated name. (still not race safe!)
+ * 	when freeing the hubs, take care not to reference free'ed memory.
+ *
+ * Revision 1.2  2002/07/17 03:59:46  mcr
+ * 	debugged uml_switch - added "-name" option.
+ *
+ * Revision 1.1  2002/07/14 02:48:48  mcr
+ * 	first version of merged uml_switch/uml_netjig that compiles.
+ *
  *
  * Local variables:
  * c-file-style: "linux"
Binary files uml_tools.jig4/uml_router/nethub.o and uml_tools.jig5/uml_router/nethub.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig4/uml_router/netjig.h uml_tools.jig5/uml_router/netjig.h
--- uml_tools.jig4/uml_router/netjig.h	Thu Jun  3 17:09:34 2004
+++ uml_tools.jig5/uml_router/netjig.h	Thu Jun  3 14:28:47 2004
@@ -1,3 +1,24 @@
+/*
+ * @(#) jig to exercise a UML/FreeSWAN kernel with two interfaces
+ *
+ * Copyright (C) 2001 Michael Richardson  <mcr@freeswan.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * RCSID $Id: netjig.h,v 1.3 2002/07/17 03:59:46 mcr Exp $
+ *
+ * @(#) based upon uml_router from User-Mode-Linux tools package
+ *
+ */
+
 extern char *progname;
 extern jmp_buf getMeOut;
 
@@ -20,6 +41,17 @@
 
 /*
  * $Log: netjig.h,v $
+ * Revision 1.3  2002/07/17 03:59:46  mcr
+ * 	debugged uml_switch - added "-name" option.
+ *
+ * Revision 1.2  2002/07/14 02:48:48  mcr
+ * 	first version of merged uml_switch/uml_netjig that compiles.
+ *
+ * Revision 1.1  2002/06/16 23:51:16  mcr
+ * 	revised uml_netjig - cmd mode has vastly improved, and it
+ * 	now can run a single UML in cmd mode.
+ * 	man page still missing.
+ *
  *
  * Local variables:
  * c-file-style: "linux"
diff -x CVS -x '*~' -u -N -r uml_tools.jig4/uml_router/port.c uml_tools.jig5/uml_router/port.c
--- uml_tools.jig4/uml_router/port.c	Thu Jun  3 17:09:33 2004
+++ uml_tools.jig5/uml_router/port.c	Thu Jun  3 14:46:55 2004
@@ -1,3 +1,25 @@
+/*
+ * @(#) jig to exercise a UML/FreeSWAN kernel with two interfaces
+ *
+ * Copyright (C) 2001 Jeff Dike Jeff Dike <jdike@karaya.com>
+ * Copyright (C) 2001 Michael Richardson  <mcr@freeswan.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * RCSID $Id: port.c,v 1.16 2003/04/07 02:43:22 mcr Exp $
+ *
+ * @(#) based upon uml_router from User-Mode-Linux tools package by Jeff Dike.
+ *
+ */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
Binary files uml_tools.jig4/uml_router/port.o and uml_tools.jig5/uml_router/port.o differ
Binary files uml_tools.jig4/uml_router/tuntap.o and uml_tools.jig5/uml_router/tuntap.o differ
Binary files uml_tools.jig4/uml_router/uml_switch and uml_tools.jig5/uml_router/uml_switch differ
Binary files uml_tools.jig4/uml_router/uml_switch.o and uml_tools.jig5/uml_router/uml_switch.o differ




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

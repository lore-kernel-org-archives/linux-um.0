Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7rjG-0007kU-Ki for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 01:34:58 -0700
Received: from 62-15-145-252.inversas.jazztel.es ([62.15.145.252]
	helo=saturno.agora-2000.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7rjG-0002c7-18 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 01:34:58 -0700
Message-ID: <MA6t3A81.1095323691.3565850.galan@agora-2000.com>
From: "=?ISO-8859-1?Q?Ferm=EDn?= =?ISO-8859-1?Q?Gal=E1n?="
	<fermin.galan@agora-2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Read method for /proc/mconsole
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
Date: Thu, 16 Sep 2004 10:34:51 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: vnuml-devel@mail.dit.upm.es


Hello,

I'm working in the arch/um/drivers/mconsole_kern.c code in order to
implement a reading method for /proc/mconsole that allows me to send by
the "notify" socket in the host and receive in /proc/mconsole (exactly
the opposite to the current /proc/mconsole -> notify sockect mechanism).

In create_proc_mconsole I've changed the ent->read_proc from 'NULL' to
a handle function, read_proc_mconsole

   ent->read_proc =3D read_proc_mconsole;

My problem now is how to implement read_proc_mconsole:

static int read_proc_mconsole(char *page, char **start, off_t off,
                              int count, int *eof, void *data)
{
   ...
}

The problems that I'm facing are:

- I've found out the right header for the function in
include/linux/proc_fs.h (the read_proc_t typedef), but I don't know
what the arguments means and I wasn't able to find documentation about
it. Anyone can give a pointer to this information?

- The nofity socket descriptor is hold in the notify_socket global
variable, set up in mconsole_setup function. It seems that for pushing
information to the socket, the mconsole_notify method is called (defined
in mconsole_user.c). What function should I use to pull information from
the socket?

Before you blame me, note that I am a kernel newbie :)

Thank you!

------
Ferm=EDn


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

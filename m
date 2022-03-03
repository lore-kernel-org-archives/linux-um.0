Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPgI6-005dSA-0i
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 07:54:27 +0000
Received: by mail-qt1-x82f.google.com with SMTP id 11so3902389qtt.9
 for <linux-um@lists.infradead.org>; Wed, 02 Mar 2022 23:54:24 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 0/4] Improvements to port on various error conditions
Date: Thu,  3 Mar 2022 01:53:29 -0600
Message-Id: <cover.1646292328.git.development@efficientek.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: Glenn Washburn <development@efficientek.com>

This patch series was inspired by the various issues I ran into while trying
login to a UML instance via telnet when using the ssl=port:XXXX option. The
issue was that I started the UML instance with option "ssl1=port:12345" and
when I tried to connect from the host using telnet, the telnet client connects
and immediately the connection is closed. In the UML instance, the only message
I was getting was a kernel log message "port_accept : port_connection returned 2".
I had to dig in the kernel source to figure out what the "2" meant, which gave
a clue as to what was going on.

The issue was that I didn't have in.telnetd installed and the "2" was the error
code from exec, which is ENOENT, or "No such file or directory". Patch #4
provides a more user friendly error on exec failure, which should prevent
users from needing to dig in the source to figure out what's going wrong.

The first patch allows exec to search for in.telnetd instead of having its
path hard coded, which may be different on different systems. It also allows
for the UML instance to be telneted into when the user is unprivileged and
the host does not have in.telnetd installed. The user can install in.telnetd
in to any path they can write to and set PATH accordingly. This is my actual
use case.

The second patch allows the user to specify the location of the port-helper
binary via the environment variable UML_PORT_HELPER. The use cause is the
same as above. If the envvar is not set, fallback to the hardcoded path to
port-helper.


The third patch checks if the port-helper path actually exists and is executable.
This allows the UML instance to check and fail early if port-helper can't be
run and to send and error message to the user via the kernel log letting the
user know the issue and potentially how to fix it (eg. set the UML_PORT_HELPER
envvar).

Glenn

Glenn Washburn (4):
  um: port_user: Search for in.telnetd in PATH
  um: port_user: Allow setting path to port-helper using UML_PORT_HELPER
    envvar
  um: port_user: Improve error handling when port-helper is not found
  um: run_helper: Write error message to kernel log on exec failure on
    host

 arch/um/drivers/port_user.c | 18 +++++++++++++++++-
 arch/um/os-Linux/helper.c   |  5 +++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


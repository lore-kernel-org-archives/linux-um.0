Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxURl-0004UP-H5
 for linux-um@lists.infradead.org; Thu, 07 Jan 2021 12:31:22 +0000
Received: by mail-wm1-x333.google.com with SMTP id c124so5004070wma.5
 for <linux-um@lists.infradead.org>; Thu, 07 Jan 2021 04:31:19 -0800 (PST)
From: Joshua Hawking <joshuahawking1@gmail.com>
Subject: Replacing a legacy uml-switch with bess
Message-ID: <78c472a8-741c-bdad-4e34-896bd968af5e@gmail.com>
Date: Thu, 7 Jan 2021 12:31:16 +0000
MIME-Version: 1.0
Content-Language: en-US
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
To: linux-um@lists.infradead.org
Cc: anton.ivanov@cambridgegreys.com

Hi everyone,

I currently maintain a project called Netkit which facilitates network
simulation using UML machines. This project is quite old and we've been
working on upgrading it to a modern codebase.

Netkit relies on using uml_net for communication between the machines.
It uses the legacy uml_switches to create hubs that connect to the
machine, using the old ethX command line parameters. For example:

/home/josh/netkit-kernel
--eth0=daemon,,,/home/josh/.netkit/vhub_Internet.cnct

where the vhub_Internet.cnct is the uml_switch socket. We're looking to
upgrade this to use the new vector networking to utilize the better
performance and remove legacy code that could break on a kernel update.

I've been looking at the linux kernel documentation that discusses using
the Bess switch software to provide networking between UML machines.
(https://github.com/torvalds/linux/blob/master/Documentation/virt/uml/user_mode_linux_howto_v2.rst#bess-socket-transport)

However, I can't find any good examples of using Bess with UML and was
wondering whether anyone on the mailing list has any advice/examples.

I noted that Anton had submitted a PR to Bess to improve UML support and
I was wondering whether this means that the build without this patch
would not work with UML at all.

https://github.com/NetSys/bess/pull/1022

Hopefully someone may be able to point me in the right direction on
handling uml_switch removal!

Thanks,

Josh



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


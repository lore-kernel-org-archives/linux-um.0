Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGxs-00GLfO-8m
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 20:22:26 +0000
Message-ID: <5fee882c709f6c9d061b58a0e7b3110b3afbb96e.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Mar 2021 21:22:19 +0100
In-Reply-To: <m21rcv5vi5.wl-thehajime@gmail.com>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
 <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
 <m21rcv5vi5.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, anton.ivanov@kot-begemot.co.uk, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org

On Thu, 2021-03-04 at 14:38 +0900, Hajime Tazaki wrote:
> 
> objcopy (from binutils) can localize symbols (i.e., objcopy -L
> sem_init $orig_file $new_file).

This doesn't seem to be sufficient.

> It also does renaming symbols.  But
> not sure this is the ideal solution.

Even that doesn't seem to actually work/help? I still get libcom_err
trying to call UML's sem_init, even after doing
 objcopy --redefine-sym sem_init=uml_sem_init


> How does UML handle symbol conflicts between userspace code and Linux
> kernel (like this case sem_init) ?  AFAIK, libnl has a same symbol as
> Linux kernel (genlmsg_put) and others can possibly do as well.

I think like I said it just doesn't but since you don't have much
userspace code linked with UML it never really mattered?

We only link a 'linux' binary, after all. How does LKL handle this
though? It should be far more affected?


Despite the objcopy *not* fixing it, this does seem to:

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index dacbfabf66d8..2f2a8ce92f1e 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -6,6 +6,12 @@ OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
 jiffies = jiffies_64;
 
+VERSION {
+  {
+    local: *;
+  };
+}
+
 SECTIONS
 {
   PROVIDE (__executable_start = START);
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 45d957d7004c..7a8e2b123e29 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -7,6 +7,12 @@ OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
 jiffies = jiffies_64;
 
+VERSION {
+  {
+    local: *;
+  };
+}
+
 SECTIONS
 {
   /* This must contain the right address - not quite the default ELF one.*/

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


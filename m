Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIEQV-00FpcD-Bw
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 17:39:51 +0000
Subject: Re: linux uml segfault
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
 <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c016e628-5c28-e732-d99d-7b2f10e3c5a3@kot-begemot.co.uk>
Date: Fri, 5 Mar 2021 17:39:42 +0000
MIME-Version: 1.0
In-Reply-To: <3c447c59bc30ba2bae1130ec89beddd699a0d21a.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, Hajime Tazaki <thehajime@gmail.com>
Cc: rrs@debian.org, chris.obbard@collabora.com, linux-um@lists.infradead.org, 983379@bugs.debian.org



On 04/03/2021 07:47, Johannes Berg wrote:
> On Thu, 2021-03-04 at 14:38 +0900, Hajime Tazaki wrote:
> 
>>> Now, I don't know how to fix it (short of changing your nsswitch
>>> configuration) - maybe we could somehow rename sem_init()? Or maybe we
>>> can somehow give the kernel binary a lower symbol resolution than the
>>> libc/libpthread.
>>
>> objcopy (from binutils) can localize symbols (i.e., objcopy -L
>> sem_init $orig_file $new_file).  It also does renaming symbols.  But
>> not sure this is the ideal solution.
> 
> Yes, we started thinking about it but it was too late at night when I
> replied ...
> 
> I think there's basically a way to have an external list of symbols to
> export, for symbol versioning, that we could/should use to basically not
> export any of the kernel symbols out to libs.
> 
>> How does UML handle symbol conflicts between userspace code and Linux
>> kernel (like this case sem_init) ?  AFAIK, libnl has a same symbol as
>> Linux kernel (genlmsg_put) and others can possibly do as well.
> 
> I fear it doesn't?

Let's assume it does not, and try to fix this by de-conflicting the symbol.
For the time being, also, let's aim for a Debian specific patch just to go into their "patches" dir for build so that UML is not dropped out of the release.

This should make all internal uses of sem_init be um_sem_init in the actual object files. I will chase the issue of it picking up glibc memcpy separately.
Upon close inspection it looks like a different issue - it is in the other direction (picking a dynamic symbol instead of the one from the tree). I spent all day chasing it today and I cannot reproduce it. At the same time it was reproducible yesterday without any problems :(

Ritesh, can you give the following a spin - it renames sem_init as um_sem_init for UML only?

diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..5157796daf54 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -263,7 +263,11 @@ void sem_exit_ns(struct ipc_namespace *ns)
  }
  #endif

+#ifdef CONFIG_UML
+void __init um_sem_init(void)
+#else
  void __init sem_init(void)
+#endif
  {
         sem_init_ns(&init_ipc_ns);
         ipc_init_proc_interface("sysvipc/sem",
diff --git a/ipc/util.h b/ipc/util.h
index 5766c61aed0e..b3356efb3c96 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -47,7 +47,12 @@ extern int ipc_min_cycle;
  #define IPCMNI_IDX_MASK                ((1 << IPCMNI_SHIFT) - 1)
  #endif /* CONFIG_SYSVIPC_SYSCTL */

+#ifdef CONFIG_UML
+void um_sem_init(void);
+#define sem_init() um_sem_init()
+#else
  void sem_init(void);
+#endif
  void msg_init(void);
  void shm_init(void);



> 
> johannes
> 
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


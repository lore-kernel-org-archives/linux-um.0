Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5TT-RJ
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:41 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/6] um: fix up CONFIG_GCOV support
Date: Fri, 12 Mar 2021 10:55:20 +0100
Message-Id: <20210312095526.197739-1-johannes@sipsolutions.net>
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

CONFIG_GCOV is fairly useful for ARCH=um (e.g. with kunit, though
my main use case is a bit different) since it writes coverage data
directly out like a normal userspace binary. Theoretically, that
is.

Unfortunately, it's broken in multiple ways today:

 1) it doesn't like, due to 'mangle_path' in seq_file, and the only
    solution to that seems to be to rename our symbol, but that's
    not so bad, and "mangle_path" sounds very generic anyway, which
    it isn't quite

 2) gcov requires exit handlers to write out the data, and those are
    never called for modules, config CONSTRUCTORS exists for init
    handlers, so add CONFIG_MODULE_DESTRUCTORS here that we can then
    select in ARCH=um

 3) As mentioned above, gcov requires init/exit handlers, but they
    aren't linked into binary properly, that's easy to fix.

 4) gcda files are then written, so .gitignore them

 5) it's not always useful to create coverage data for the *entire*
    kernel, so I've split off CONFIG_GCOV_BASE from CONFIG_GCOV to
    allow option in only in some places, which of course requires
    adding the necessary "subdir-cflags" or "CFLAGS_obj" changes in
    the places where it's desired, as local patches.


None of these changes (hopefully) seem too controversional, biggest
are the module changes but obviously they compile to nothing if the
architecture doesn't WANT_MODULE_DESTRUCTORS.

Any thoughts on how to merge this? The seq_file/.gitignore changes
are independent at least code-wise, though of course it only works
with the seq_file changes (.gitignore doesn't matter, of course),
while the module changes are a requirement for the later ARCH=um
patches since the Kconfig symbol has to exist.

Perhaps I can just get ACKs on all the patches and then they can go
through the UML tree?

Thanks,
johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


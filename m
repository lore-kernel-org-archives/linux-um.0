Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 26 Jun 2020 14:52:37 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to
 dispatch all KUnit tests
Message-ID: <202006261442.5C245709@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-doc@vger.kernel.org, catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org, paulus@samba.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, anton.ivanov@cambridgegreys.com, linux-arch@vger.kernel.org, richard@nod.at, rppt@linux.ibm.com, benh@kernel.crashing.org, yzaikin@google.com, linux-xtensa@linux-xtensa.org, arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, davidgow@google.com, skhan@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, chris@zankel.net, monstr@monstr.eu, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, alan.maguire@oracle.com, mpe@ellerman.id.au, akpm@linux-foundation.org, logang@deltatee.com
List-ID: <linux-um.lists.infradead.org>

On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

So, the new section looks fine to me (modulo the INIT_DATA change). The
plumbing to start the tests, though, I think is redundant. Why not just
add a sysctl that starts all known tests?

That way you don't need the plumbing into init/main.c, and you can have
a mode where builtin tests can be started on a fully booted system too.

i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
"echo start > /proc/sys/kernel/kunit"

And instead of the kunit-specific halt/reboot stuff, how about moving
/proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
do:

sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


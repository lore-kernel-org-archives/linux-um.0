Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 16/15 v2] syscall_get_arch: add "struct task_struct *"
 argument
Date: Wed, 21 Nov 2018 19:45:51 +0000
Message-ID: <20181121194549.4glznckje73z2uxk@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
 <20181121184004.jro532jopnbmru2m@pburton-laptop>
 <20181121190009.GA10301@altlinux.org> <20181121193512.GA11297@altlinux.org>
In-Reply-To: <20181121193512.GA11297@altlinux.org>
Content-Language: en-US
Content-ID: <708ADDE084183B41A3B884270BF84771@namprd22.prod.outlook.com>
MIME-Version: 1.0
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
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Eugene Syromyatnikov <esyr@redhat.com>, Elvira Khabirova <lineprinter@altlinux.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, Andy Lutomirski <luto@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>, "linux-audit@redhat.com" <linux-audit@redhat.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-um.lists.infradead.org>

Hi Dmitry,

On Wed, Nov 21, 2018 at 10:35:12PM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
> 
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-audit@redhat.com
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: x86@kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> v2: cleaned up mips part, added Reviewed-by

I thought the last one was v2? :)

Anyway, this looks fine to me now:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Tue, 26 Nov 2019 16:59:11 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [GIT PULL] seccomp updates for v5.5-rc1
In-Reply-To: <201911260818.9C5DC1E@keescook>
Message-ID: <alpine.DEB.2.21.9999.1911261656110.23039@viisi.sifive.com>
References: <201911260818.9C5DC1E@keescook>
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
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kselftest@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>, Daniel Borkmann <daniel@iogearbox.net>, kernel test robot <rong.a.chen@intel.com>, x86@kernel.org, Yonghong Song <yhs@fb.com>, Borislav Petkov <bp@suse.de>, linux-um@lists.infradead.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, David Abdurachmanov <david.abdurachmanov@sifive.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Martin KaFai Lau <kafai@fb.com>
List-ID: <linux-um.lists.infradead.org>

On Tue, 26 Nov 2019, Kees Cook wrote:

> Most notably, the secure_computing() prototype has changed (to remove an 
> unused argument), but this has happened at the same time as riscv adding 
> seccomp support, so the cleanest merge order would be to merge riscv 
> first, then seccomp with the following patch for riscv to handle the 
> change from "seccomp: simplify secure_computing()":

The RISC-V pull request that contains the seccomp change has been sent.  
It's here:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com/T/#u


- Paul

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


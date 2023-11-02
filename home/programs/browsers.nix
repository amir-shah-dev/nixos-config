{ options, config, lib, pkgs, inputs, ... }:

{
  programs.chromium = {
     enable = true;
     package = pkgs.ungoogled-chromium;
     extensions =
       let
         createChromiumExtensionFor = browserVersion: { id, sha256, version }:
           {
             inherit id;
             crxPath = builtins.fetchurl {
               url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
               name = "${id}.crx";
               inherit sha256;
             };
             inherit version;
           };
         createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
       in
       [
         (createChromiumExtension {
           # ublock origin
           id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
           sha256 = "sha256:15pxy8nmk3803x8wkmyqy5zgi6vf6fh4df96jzkp282fw6pw5rxr";
           version = "1.52.2";
         })
         (createChromiumExtension {
           # Bitwarden
           id = "nngceckbapebfimnlniiiahkandclblb";
           sha256 = "sha256:1s3mcgabng3fqnqr857sbidp4p9yaapr91bz1vjpp1i43f7wybfd";
           version = "2023.9.1";
         })         
         (createChromiumExtension {
           # Decentraleyes
           id = "ldpochfccmkkmhdbclfhpagapcfdljkj";
           sha256 = "sha256:104hxil166y87yx3q5rx58plizwybfb67hw3ivdl6vpbm4w96v0n";
           version = "2.0.18";
         })
         (createChromiumExtension {
           # I Still Don't Care About Cookies
           id = "edibdbjcniadpccecjdfdjjppcpchdlm";
           sha256 = "sha256:1jv84z0186nblwq5977fcqcah729xkj25lir03jj1whn951nvkpb";
           version = "1.1.1";
         })
         (createChromiumExtension {
           # Vimium
           id = "dbepggeogbaibhgnhhndojpepiihcmeb";
           sha256 = "sha256:1z1zwdgl1v3c99nn21r9rjnqk2n8i52mffsspdga8ma1d0x0h551";
           version = "2.0.3";
         })
         (createChromiumExtension {
           # Omnivore
           id = "blkggjdmcfjdbmmmlfcpplkchpeaiiab";
           sha256 = "sha256:0rgqkys36lvdxlsc81s1dp8gwgxyzl4s6j68x2ivixsc714pgxvc";
           version = "2.6.2";
         })
       ];
     commandLineArgs = [
      "--force-dark-mode"
      # "--extension-mime-request-handling=always_prompt_for_install"
     ];
    };
}


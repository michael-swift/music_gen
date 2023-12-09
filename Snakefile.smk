import random
# Define the styles
num_generations = 100

# TODO extend the list
styles = ["80s pop track with bassy drums and synth", "90s rock song with loud guitars and heavy drums"]

rule all:
  input:
      expand("output/{number}.mp3", number=range(1, num_generations + 1))

rule download_model:
    output:
        "models/musicgen_pretrained.pt"
    conda: 
        "audio.yml"
    run:
        from audiocraft.models import MusicGen
        model = MusicGen.get_pretrained('facebook/musicgen-melody')
        torch.save(model.state_dict(), output[0])

rule generate_music:
    input:
        melody="data/amazing_grace.mp3"
    output:
        music="output/{number}.mp3"
    params:
        style=lambda wildcards: random.choice(styles),
        use_diffusion_decoder=True  # or False, depending on your needs
    conda: 
        "audio.yml"
    script:
        "scripts/generate_musics.py --input_melody {input.melody} --output_path {output.music} --style {params.style} --use_diffusion_decoder {params.use_diffusion_decoder}"